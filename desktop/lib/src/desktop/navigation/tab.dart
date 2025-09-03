import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../input/input.dart';
import '../theme/theme.dart';
import 'nav_button.dart' show NavMenuMixin;
import 'tab_scope.dart';
import 'tab_view.dart';

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
    if (_index != value) {
      _index = value;
      notifyListeners();
    }
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
  const TabItem({required this.itemBuilder, required this.builder});

  /// Creates a [TabItem] with a [Text] title.
  factory TabItem.text(String title, {required WidgetBuilder builder}) {
    return TabItem(itemBuilder: (context) => Text(title), builder: builder);
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
      itemBuilder: itemBuilder,
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
  const TabMenuItem({required this.builder, required this.itemBuilder});

  /// Creates a [TabMenuItem] with a [Text] title.
  factory TabMenuItem.text(String title, {required WidgetBuilder builder}) {
    return TabMenuItem(builder: builder, itemBuilder: (context) => Text(title));
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
    this.leading,
    this.trailing,
    this.controller,
    this.trailingMenu,
    this.axis = AxisDirection.up,
  }) : assert(items.length > 0);

  /// Tab items.
  final List<TabItem> items;

  /// The trailing widget that will placed at the start of the tab bar.
  final WidgetBuilder? leading;

  /// The trailing widget that will placed at the end of the tab bar.
  final WidgetBuilder? trailing;

  /// The menu items placed after the tab bar and before [trailing].
  final List<TabMenuItem>? trailingMenu;

  /// Controls selected index.
  final TabController? controller;

  /// The [AxisDirection] of the tab bar.
  final AxisDirection axis;

  @override
  State<Tab> createState() => _TabState();
}

class _TabState extends State<Tab>
    with SingleTickerProviderStateMixin, NavMenuMixin {
  final List<bool> _shouldBuildView = <bool>[];

  final List<OverlayEntry> _overlays = List<OverlayEntry>.empty(growable: true);

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  late Duration _menuTransitionDuration;
  late Curve _menuTrasitionCurve;
  late Color _tabBarBackgroundColor;

  @override
  OverlayState get overlay => _overlayKey.currentState!;

  @override
  Duration get menuTransitionDuration => _menuTransitionDuration;

  @override
  Curve get menuTransitionCurve => _menuTrasitionCurve;

  @override
  Color get navBarBackgroundColor => _tabBarBackgroundColor;

  @override
  Color get barrierColor => DialogTheme.of(context).barrierColor!;

  @override
  ImageFilter get filter => DialogTheme.of(context).imageFilter!;

  TabController? _internalController;
  TabController get _controller => widget.controller ?? _internalController!;

  ScrollController? _scrollController;

  int get _length => widget.items.length;

  Axis get _direction =>
      widget.axis == AxisDirection.up || widget.axis == AxisDirection.down
      ? Axis.horizontal
      : Axis.vertical;

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

  void _handleMenuAnimationStatusChanged(AnimationStatus status) =>
      setState(() => handleMenuAnimationStatusChanged(status));

  void _showMenu(int index) {
    final builders = [...widget.trailingMenu!.map((e) => e.builder)];

    setState(() {
      showMenu(index, axis: widget.axis, builders: builders, isInfoMenu: false);
    });
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
  ) {
    final List<Widget> menuItems = List<Widget>.generate(tabMenuItems.length, (
      index,
    ) {
      final active = index == menuIndex;

      return ButtonTheme(
        data: ButtonThemeData(
          color: themeData.itemHighlightColor!,
          highlightColor: themeData.itemColor!,
          hoverColor: themeData.itemHoverColor!,
        ),
        child: Button(
          onPressed: () => _showMenu(index),
          active: active,
          body: Builder(
            builder: (context) => Container(
              alignment: _direction == Axis.horizontal
                  ? Alignment.center
                  : Alignment.centerLeft,
              padding: themeData.itemPadding!,
              child: tabMenuItems[index].itemBuilder(context),
            ),
          ),
          bodyPadding: EdgeInsets.zero,
          leadingPadding: EdgeInsets.zero,
          trailingPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      );
    });

    return Flex(
      direction: _direction,
      mainAxisSize: MainAxisSize.min,
      children: menuItems,
    );
  }

  Widget _createTabItems(TabThemeData themeData) {
    _scrollController ??= ScrollController();

    final List<Widget> tabItems = List<Widget>.generate(widget.items.length, (
      index,
    ) {
      final bool active = _controller.index == index && !menuShown;

      return ButtonTheme(
        data: ButtonThemeData(
          color: themeData.itemHighlightColor!,
          highlightColor: themeData.itemColor!,
          hoverColor: themeData.itemHoverColor!,
          background: themeData.itemBackgroundColor,
          hoverBackground: themeData.itemHoverBackgroundColor,
          highlightBackground: themeData.itemHighlightBackgroundColor,
        ),
        child: Button(
          filled: themeData.itemFilled!,
          onPressed: () {
            setState(hideMenu);
            _indexChanged(index);
          },
          active: active,
          body: Builder(
            builder: (context) => Container(
              alignment: _direction == Axis.horizontal
                  ? Alignment.center
                  : Alignment.centerLeft,
              padding: themeData.itemPadding!,
              child: widget.items[index].itemBuilder(context),
            ),
          ),
          bodyPadding: EdgeInsets.zero,
          leadingPadding: EdgeInsets.zero,
          trailingPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      );
    });

    final double minWidth = _direction == Axis.horizontal ? 128.0 : 0.0;
    final double minHeight = _direction == Axis.vertical ? 128.0 : 0.0;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: _direction,
          child: Flex(
            direction: _direction,
            mainAxisSize: MainAxisSize.min,
            children: tabItems,
          ),
        ),
      ),
    );
  }

  Widget _createTabBar(TabThemeData themeData) {
    Widget result = Container(
      padding: themeData.padding!,
      color: themeData.tabBarBackgroundColor!,
      child: Flex(
        direction: _direction,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.leading != null) widget.leading!(context),
          Expanded(child: _createTabItems(themeData)),
          if (widget.trailingMenu != null && widget.trailingMenu!.isNotEmpty)
            _createMenuItems(themeData, widget.trailingMenu!),
          if (widget.trailing != null) widget.trailing!(context),
        ],
      ),
    );

    final double height = themeData.height!;
    final double width = themeData.width!;

    if (_direction == Axis.horizontal) {
      if (height != 0.0) {
        result = SizedBox(height: height, child: result);
      } else {
        result = IntrinsicHeight(child: result);
      }
    }

    if (_direction == Axis.vertical) {
      if (width != 0.0) {
        result = SizedBox(width: width, child: result);
      } else {
        result = IntrinsicWidth(child: result);
      }
    }

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

    _overlays.addAll(
      List<OverlayEntry>.generate(
        _length,
        (index) => _createPageOverlayEntry(index),
      ),
    );

    _updateTabController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final TabThemeData themeData = TabTheme.of(context);

    _menuTransitionDuration = themeData.menuTransitionDuration!;
    _menuTrasitionCurve = themeData.menuTrasitionCurve!;
    _tabBarBackgroundColor = themeData.tabBarBackgroundColor!;

    menuController ??= AnimationController(
      vsync: this,
      duration: themeData.menuTransitionDuration!,
    )..addStatusListener(_handleMenuAnimationStatusChanged);

    menuAnimation ??= CurvedAnimation(
      parent: menuController!,
      curve: themeData.menuTrasitionCurve!,
      reverseCurve: themeData.menuTrasitionReverseCurve!,
    );
  }

  @override
  void didUpdateWidget(Tab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(
        List<bool>.filled(widget.items.length - _shouldBuildView.length, false),
      );

      for (
        int index = _overlays.length;
        index < widget.items.length - _shouldBuildView.length;
        index += 1
      ) {
        _overlays.add(_createPageOverlayEntry(index));
      }
    } else if (widget.items.length - _shouldBuildView.length < 0) {
      _shouldBuildView.removeRange(
        widget.items.length,
        _shouldBuildView.length,
      );

      for (final overlayEntry in _overlays.getRange(
        widget.items.length,
        _overlays.length,
      )) {
        overlayEntry.remove();
      }

      _overlays.removeRange(widget.items.length, _overlays.length);
    }

    if (widget.controller != oldWidget.controller) {
      _updateTabController(oldWidget.controller);
    } else {
      final int index = math.min(_controller.index, widget.items.length - 1);
      if (index != _controller.index) {
        _controller.index = index;
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller?._isDisposed == false) {
      _controller.removeListener(_onCurrentIndexChange);
    }

    _internalController?.dispose();
    menuController?.removeStatusListener(_handleMenuAnimationStatusChanged);
    menuController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TabThemeData themeData = TabTheme.of(context);

    Widget result = Flex(
      direction: _direction == Axis.horizontal
          ? Axis.vertical
          : Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.axis == AxisDirection.up ||
            widget.axis == AxisDirection.left)
          _createTabBar(themeData),
        Expanded(
          child: Overlay(key: _overlayKey, initialEntries: _overlays),
        ),
        if (widget.axis == AxisDirection.right ||
            widget.axis == AxisDirection.down)
          _createTabBar(themeData),
      ],
    );

    result = TabScope(
      currentIndex: _controller.index,
      axis: _direction,
      child: result,
    );

    return result;
  }
}
