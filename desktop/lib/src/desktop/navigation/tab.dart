import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/input.dart';
import '../theme/theme.dart';
import 'tab_scope.dart';
import 'tab_view.dart';

const Duration _kMenuTransitionDuration = Duration(milliseconds: 300);

/// Controls the tab index.
class TabController extends ChangeNotifier {
  /// Creates a [TabController].
  TabController({int initialIndex = 0})
      : _index = initialIndex,
        assert(initialIndex >= 0);

  bool _isDisposed = false;

  /// The index of the currently selected tab.
  int get index => _index;
  int _index;
  set index(int value) {
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}

/// Represents a item in a tab bar.
/// See:
///   [Tab]
class TabItem {
  /// Creates a [TabItem].
  const TabItem({
    required this.builder,
    required this.itemBuilder,
  });

  /// Creates a [TabItem] with a [Text] title.
  factory TabItem.text(
    String title, {
    required WidgetBuilder builder,
  }) {
    return TabItem(
      builder: builder,
      itemBuilder: (context) => Text(title),
    );
  }

  /// Creates a [TabItem] with a navigation history.
  factory TabItem.navigator({
    required WidgetBuilder builder,
    required WidgetBuilder itemBuilder,
    GlobalKey<NavigatorState>? navigatorKey,
    String? defaultTitle,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver> navigatorObservers = const [],
  }) {
    return TabItem(
      builder: (context) => TabView(
        builder: builder,
        navigatorKey: navigatorKey,
        defaultTitle: defaultTitle,
        key: navigatorKey,
        navigatorObservers: navigatorObservers,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        routes: routes,
      ),
      itemBuilder: itemBuilder,
    );
  }

  /// A custom item to be built for the tab bar.
  final WidgetBuilder itemBuilder;

  /// The widget builder for the tab view.
  final WidgetBuilder builder;
}

/// Represents a item in menu.
/// See:
///   [Tab]
class TabMenuItem {
  /// Creates a [TabMenuItem].
  const TabMenuItem({
    required this.builder,
    required this.itemBuilder,
  });

  /// Creates a [TabMenuItem] with a [Text] title.
  factory TabMenuItem.text(
    String title, {
    required WidgetBuilder builder,
  }) {
    return TabMenuItem(
      builder: builder,
      itemBuilder: (context) => Text(title),
    );
  }

  /// A custom item to be built for the menu.
  final WidgetBuilder itemBuilder;

  /// The widget builder for the menu view.
  final WidgetBuilder builder;
}

/// Navigation tab.
///
/// The difference with [Nav], is that [Tab] is simpler and only supports horizontal axis for the item
/// and widgets may also be used as tabs, meanwhile only text can be used in [Nav] bar.
///
/// ```dart
/// Tab(
///   items: [
///     TabItem.text(
///       'page1',
///       builder: (context, _) => Center(child: Text()),
///     ),
///     TabItem.text(
///       'page2',
///       builder: (context, _) => Center(child: Text('page2')),
///     ),
///     TabItem.text(
///       'page3',
///       builder: (context, _) => Center(child: Text('page3')),
///     ),
///   ],
/// )```
class Tab extends StatefulWidget {
  ///
  const Tab({
    super.key,
    required this.items,
    this.trailing,
    this.themeData,
    this.controller,
    this.leadingMenu,
    this.trailingMenu,
    this.axis = Axis.horizontal,
  }) : assert(items.length > 0);

  /// Tab items.
  final List<TabItem> items;

  /// The trailing widget that will placed at the end of the tab bar.
  final WidgetBuilder? trailing;

  /// The menu items placed after the tab bar and before [trailing].
  final List<TabMenuItem>? trailingMenu;

  /// The menu items placed before the tab bar.
  final List<TabMenuItem>? leadingMenu;

  /// The theme for [Tab].
  final TabThemeData? themeData;

  /// Controls the currently selected tab index of [Tab].
  final TabController? controller;

  /// The [Axis] of the tab bar.
  final Axis axis;

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> with SingleTickerProviderStateMixin {
  final List<bool> _shouldBuildView = <bool>[];

  final List<OverlayEntry> _overlays = List<OverlayEntry>.empty(growable: true);

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  OverlayState get _overlay => _overlayKey.currentState!;

  int _menuIndex = -1;
  bool _menuShown = false;
  OverlayEntry? _menuOverlay;
  late Animation<double> _menuAnimation;
  late AnimationController _menuController;
  late Tween<Offset> _menuOffsetTween;
  final ColorTween _menuColorTween = ColorTween();

  static const Curve _animationCurve = Curves.easeInOutSine;

  void _createAnimation() {
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: _animationCurve,
      reverseCurve: _animationCurve,
    );

    final Offset begin = widget.axis == Axis.vertical
        ? const Offset(-1.0, 0.0)
        : const Offset(0.0, -1.0);
    const Offset end = Offset(0.0, 0.0);

    _menuOffsetTween = Tween<Offset>(
      begin: begin,
      end: end,
    );
  }

  TabController? _internalController;
  TabController get _controller => widget.controller ?? _internalController!;

  ScrollController? _scrollController;

  int get _length => widget.items.length;

  // late Map<Type, Action<Intent>> _actionMap;

  // void _nextView() => _indexChanged((_index + 1) % _length);

  // void _previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _controller.index) {
      if (index < 0 ||
          index >= _length ||
          Navigator.of(context, rootNavigator: true).canPop()) {
        return false;
      }

      setState(() => _controller.index = index);

      return true;
    }

    return false;
  }

  void _handleMenuAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _menuOverlay?.remove();
      _menuOverlay = null;
      setState(() => _menuIndex = -1);
    }
  }

  void _hideMenu() {
    setState(() {
      _menuController.reverse();
      _menuShown = false;
    });
  }

  int _getMenuIndex(bool isTrailing, int index) {
    final int leadingLength = widget.leadingMenu?.length ?? 0;
    return isTrailing ? leadingLength + index : index;
  }

  void _showMenu(TabThemeData themeData, bool isTrailing, int index) {
    setState(() {
      if (_menuIndex == -1) {
        _menuIndex = _getMenuIndex(isTrailing, index);

        final Color barrierColor = DialogTheme.of(context).barrierColor!;
        _menuColorTween.begin = barrierColor.withOpacity(0.0);
        _menuColorTween.end = barrierColor;

        final List<TabMenuItem> items = [
          ...widget.leadingMenu ?? [],
          ...widget.trailingMenu ?? []
        ];

        _menuOverlay = OverlayEntry(
          maintainState: false,
          builder: (context) => AnimatedBuilder(
            animation: _menuAnimation,
            builder: (context, _) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _hideMenu,
              child: Container(
                alignment: widget.axis == Axis.vertical
                    ? Alignment.centerLeft
                    : Alignment.topCenter,
                color: _menuColorTween.evaluate(_menuAnimation),
                child: GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {},
                  child: ClipRect(
                    child: FractionalTranslation(
                      translation: _menuOffsetTween.evaluate(_menuAnimation),
                      child: Container(
                        width: widget.axis == Axis.vertical
                            ? null
                            : double.infinity,
                        height: widget.axis == Axis.horizontal
                            ? null
                            : double.infinity,
                        color: themeData.tabBarBackgroundColor!,
                        child: AnimatedSize(
                          duration: _kMenuTransitionDuration,
                          curve: _animationCurve,
                          child: items[_menuIndex].builder(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        _overlay.insert(_menuOverlay!);
        _menuController.forward(from: 0.0);
        _menuShown = true;
      } else if (_menuIndex == _getMenuIndex(isTrailing, index)) {
        _hideMenu();
      } else {
        _menuIndex = _getMenuIndex(isTrailing, index);
      }
    });

    print(_menuIndex);
  }

  void _updateTabController([TabController? oldWidgetController]) {
    if (widget.controller == null && _internalController == null) {
      _internalController = TabController();
    }
    if (widget.controller != null && _internalController != null) {
      _internalController!.dispose();
      _internalController = null;
    }
    if (oldWidgetController != widget.controller) {
      if (oldWidgetController?._isDisposed == false) {
        oldWidgetController!.removeListener(_onCurrentIndexChange);
      }
      widget.controller?.addListener(_onCurrentIndexChange);
    }
  }

  void _onCurrentIndexChange() {
    assert(_controller.index >= 0 && _controller.index < _length);
    setState(() {});
  }

  OverlayEntry _createPageOverlayEntry(int index) {
    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        final bool active = index == _controller.index;
        _shouldBuildView[index] = active || _shouldBuildView[index];

        return Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
            child: Builder(
              builder: _shouldBuildView[index]
                  ? (context) => widget.items[index].builder(context)
                  : (context) => const SizedBox(),
            ),
          ),
        );
      },
    );
  }

  Widget _createMenuItems(
    TabThemeData themeData,
    List<TabMenuItem> tabMenuItems,
    bool isTrailing,
  ) {
    final List<Widget> menuItems =
        List<Widget>.generate(tabMenuItems.length, (index) {
      final active = _getMenuIndex(isTrailing, index) == _menuIndex;

      return Button(
        themeData: ButtonThemeData(
          color: themeData.itemHighlightColor!,
          highlightColor: themeData.itemColor!,
          hoverColor: themeData.itemHoverColor!,
        ),
        onPressed: () => _showMenu(
          themeData,
          isTrailing,
          index,
        ),
        active: active,
        body: Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            padding: themeData.itemPadding!,
            child: tabMenuItems[index].itemBuilder(context),
          ),
        ),
        bodyPadding: EdgeInsets.zero,
        leadingPadding: EdgeInsets.zero,
        trailingPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      );
    });

    return Flex(
      direction: widget.axis,
      mainAxisSize: MainAxisSize.min,
      children: menuItems,
    );
  }

  Widget _createTabItems(TabThemeData themeData) {
    _scrollController ??= ScrollController();

    final List<Widget> tabItems =
        List<Widget>.generate(widget.items.length, (index) {
      final bool active =
          _controller.index == index && !_menuShown;

      return Button(
        filled: themeData.itemFilled!,
        themeData: ButtonThemeData(
          color: themeData.itemHighlightColor!,
          highlightColor: themeData.itemColor!,
          hoverColor: themeData.itemHoverColor!,
          background: themeData.itemBackgroundColor,
          hoverBackground: themeData.itemHoverBackgroundColor,
          highlightBackground: themeData.itemHighlightBackgroundColor,
        ),
        onPressed: () {
          if (_menuIndex != -1) {
            _hideMenu();
          }
          _indexChanged(index);
        },
        active: active,
        body: Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            padding: themeData.itemPadding!,
            child: widget.items[index].itemBuilder(context),
          ),
        ),
        bodyPadding: EdgeInsets.zero,
        leadingPadding: EdgeInsets.zero,
        trailingPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      );
    });

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 128.0),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: tabItems,
          ),
        ),
      ),
    );
  }

  Widget _createTabBar(TabThemeData themeData) {
    final Widget result = Container(
      padding: themeData.padding!,
      height: themeData.height!,
      color: themeData.tabBarBackgroundColor!,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.leadingMenu != null && widget.leadingMenu!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: themeData.itemSpacing!),
              child: _createMenuItems(themeData, widget.leadingMenu!, false),
            ),
          Expanded(
            child: _createTabItems(themeData),
          ),
          if (widget.trailingMenu != null && widget.trailingMenu!.isNotEmpty)
            _createMenuItems(themeData, widget.trailingMenu!, true),
          if (widget.trailing != null) widget.trailing!(context),
        ],
      ),
    );

    return result;
  }

  @override
  void initState() {
    super.initState();

    // _actionMap = <Type, Action<Intent>>{
    //   NextTabIntent:
    //       CallbackAction<NextTabIntent>(onInvoke: (_) => _nextView()),
    //   PreviousTabIntent:
    //       CallbackAction<PreviousTabIntent>(onInvoke: (_) => _previousView()),
    // };

    _shouldBuildView.addAll(List<bool>.filled(_length, false));

    _overlays.addAll(List<OverlayEntry>.generate(
        _length, (index) => _createPageOverlayEntry(index)));

    _menuController = AnimationController(
      vsync: this,
      duration: _kMenuTransitionDuration,
    )..addStatusListener(_handleMenuAnimationStatusChanged);

    _updateTabController();

    _createAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Tab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
        widget.items.length - _shouldBuildView.length,
        false,
      ));

      for (int index = _overlays.length;
          index < widget.items.length - _shouldBuildView.length;
          index += 1) {
        _overlays.add(_createPageOverlayEntry(index));
      }
    } else if (widget.items.length - _shouldBuildView.length < 0) {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);

      for (final overlayEntry
          in _overlays.getRange(widget.items.length, _overlays.length)) {
        overlayEntry.remove();
      }

      _overlays.removeRange(widget.items.length, _overlays.length);
    }

    if (widget.controller != oldWidget.controller) {
      _updateTabController(oldWidget.controller);
    } else {
      final int _index = math.min(_controller.index, widget.items.length - 1);
      if (_index != _controller.index) {
        _controller.index = _index;
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller?._isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }

    _internalController?.dispose();
    _menuController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TabThemeData themeData = TabTheme.of(context).merge(widget.themeData);

    Widget result = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _createTabBar(themeData),
        Expanded(
          child: Overlay(
            key: _overlayKey,
            initialEntries: _overlays,
          ),
        ),
      ],
    );

    result = TabScope(
      currentIndex: _controller.index,
      axis: widget.axis,
      child: result,
    );

    return result;
  }
}
