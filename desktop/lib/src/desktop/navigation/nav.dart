import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../theme/theme.dart';
import 'nav_button.dart';
import 'tab_scope.dart';

export 'tab_scope.dart' show TabScope;

const Duration _kMenuTransitionDuration = Duration(milliseconds: 400);

class NavItem {
  const NavItem({
    required this.builder,
    this.title,
    this.icon,
  });

  /// Page builder.
  final IndexedWidgetBuilder builder;

  /// Icon used if the nav axis is vertical.
  final IconData? icon;

  /// The title shown in case the nav axis is horizontal.
  final String? title;
}

class NavMenuItem {
  const NavMenuItem({
    required this.builder,
    required this.icon,
    this.enabled = true,
  });

  /// An icon to be built for the menu.
  final WidgetBuilder icon;

  /// The widget builder for the menu view.
  final WidgetBuilder builder;

  final bool enabled;
}

/// Controls the tab index.
class NavController extends ChangeNotifier {
  /// Creates a [NavController].
  NavController({
    int initialIndex = 0,
  })  : _index = initialIndex,
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

class NavContext extends InheritedWidget {
  const NavContext._({
    required super.child,
    required _NavState state,
  }) : _state = state;

  final _NavState _state;

  int get index => _state._controller.index;
  set index(int value) {
    _state._controller.index = value;
  }

  int get menuIndex => _state._menuIndex;
  set menuIndex(int value) {
    _state._showMenuFromIndex(value);
  }

  @override
  bool updateShouldNotify(NavContext oldWidget) => false;
}

/// Navigation widget [Nav]...
///
///```dart
/// Nav(
///   trailingMenu: [
///     NavMenuItem(
///       title: 'home',
///       builder: (context) => NavDialog(
///         child: Container(
///           alignment: Alignment.center,
///           padding: EdgeInsets.all(32.0),
///           width: 600.0,
///           child: Text('Home page'),
///         ),
///       ),
///       icon: (context) => Icon(Icons.home)
///     ),
///     NavMenuItem(
///       title: 'settings',
///       builder: (context) => NavDialog(
///         child: Container(
///           alignment: Alignment.center,
///           padding: EdgeInsets.all(32.0),
///           width: 600.0,
///           child: Text('Settings page'),
///         ),
///       ),
///       icon: (context) => Icon(Icons.settings),
///     ),
///   ],
///   items: [
///     NavItem(
///       builder: (context, _) => Center(child: Text('page1')),
///       title: 'page1',
///       icon: Icons.today,
///     ),
///     NavItem(
///       builder: (context, _) => Center(child: Text('page2')),
///       title: 'page2',
///       icon: Icons.stars,
///     ),
///     NavItem(
///       builder: (context, _) => Center(child: Text('page3')),
///       title: 'page3',
///       icon: Icons.share,
///     ),
///   ],
/// )
///```
class Nav extends StatefulWidget {
  /// Creates a navigation bar.
  const Nav({
    super.key,
    required this.items,
    this.navAxis = Axis.vertical,
    this.trailingMenu = const [],
    this.onPressBackButton,
    this.isBackButtonEnabled,
    this.visible = true,
    this.controller,
  }) : assert(items.length > 0);

  /// The items with builder and route names for transition among pages.
  final List<NavItem> items;

  /// Menu before the navigation items.
  final List<NavMenuItem> trailingMenu;

  /// Callback for the back button.
  ///
  /// Defaults to null.
  final VoidCallback? onPressBackButton;

  /// If the back button should respond to user input.
  final bool? isBackButtonEnabled;

  /// The axis of the nav bar.
  final Axis navAxis;

  /// If the nav bar should be visible.
  final bool visible;

  /// Controls selected index.
  final NavController? controller;

  static NavContext? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavContext>();

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> with SingleTickerProviderStateMixin {
  int get _length => widget.items.length;

  int _menuIndex = -1;
  OverlayEntry? _menuOverlay;

  NavController? _internalController;
  NavController get _controller => widget.controller ?? _internalController!;

  // static final Map<LocalKey, ActionFactory> _actions =
  //     <LocalKey, ActionFactory>{
  //   NextFocusAction.key: () => NextFocusViewAction(),
  //   PreviousFocusAction.key: () => PreviousFocusViewAction(),
  // };

  // late Map<Type, Action<Intent>> _actionMap;

  final List<bool> _shouldBuildView = List<bool>.empty(growable: true);

  final List<OverlayEntry> _overlays = List<OverlayEntry>.empty(growable: true);

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  OverlayState get _overlay => _overlayKey.currentState!;

  late Animation<double> _menuAnimation;
  late AnimationController _menuController;
  late Tween<Offset> _menuOffsetTween;
  final ColorTween _menuColorTween = ColorTween();

  List<NavMenuItem> get _trailingMenu => widget.trailingMenu.reversed.toList();

  void _createAnimation() {
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.fastEaseInToSlowEaseOut,
      reverseCurve: Curves.fastEaseInToSlowEaseOut.flipped,
    );

    final Offset begin = widget.navAxis == Axis.vertical
        ? const Offset(-1.0, 0.0)
        : const Offset(0.0, -1.0);
    const Offset end = Offset(0.0, 0.0);

    _menuOffsetTween = Tween<Offset>(
      begin: begin,
      end: end,
    );
  }

  void nextView() => _indexChanged((_controller.index + 1) % _length);

  void previousView() => _indexChanged((_controller.index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _controller.index) {
      if (index < 0 || index >= _length || _menuIndex != -1) {
        return false;
      }

      setState(() => _controller.index = index);

      return true;
    }

    return false;
  }

  void _updateNavController([NavController? oldWidgetController]) {
    if (widget.controller == null && _internalController == null) {
      _internalController = NavController();
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

  void _handleMenuAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _menuOverlay?.remove();
      _menuOverlay = null;
    }
  }

  void _hideMenu() {
    if (_menuIndex != -1) {
      setState(() {
        _menuIndex = -1;
        _menuController.reverse();
      });
    }
  }

  void _showMenuFromIndex(int index) {
    _showMenu(_trailingMenu[index], index);
  }

  void _showMenu(NavMenuItem item, int index) {
    if (_menuController.isAnimating) {
      return;
    }

    if (_menuIndex == -1) {
      _menuOverlay?.remove();
      _menuOverlay = null;

      setState(() {
        _menuIndex = index;

        final Color barrierColor = DialogTheme.of(context).barrierColor!;
        _menuColorTween.begin = barrierColor.withOpacity(0.0);
        _menuColorTween.end = barrierColor.withOpacity(0.8);

        _menuOverlay = OverlayEntry(
          maintainState: false,
          builder: (context) => AnimatedBuilder(
            animation: _menuAnimation,
            builder: (context, _) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _hideMenu,
              child: Container(
                alignment: widget.navAxis == Axis.vertical
                    ? Alignment.centerLeft
                    : Alignment.topCenter,
                color: _menuColorTween.evaluate(_menuAnimation),
                child: GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {},
                  child: ClipRect(
                    child: FractionalTranslation(
                      translation: _menuOffsetTween.evaluate(_menuAnimation),
                      child: item.builder(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        _overlay.insert(_menuOverlay!);
        _menuController.forward(from: 0.0);
      });
    } else {
      _hideMenu();
    }
  }

  Widget _createMenuItems(
    EdgeInsets itemsSpacing,
    NavThemeData navThemeData,
    List<NavMenuItem> items,
  ) {
    final List<Widget> itemsMenu = List<Widget>.empty(growable: true);

    for (int i = items.length - 1; i >= 0 ; i -= 1) {
      final item = items[i];
      itemsMenu.add(
        NavMenuButton(
          item.icon(context),
          axis: widget.navAxis,
          active: _menuIndex == i,
          onPressed: items[i].enabled && (_menuIndex == -1 || _menuIndex == i)
              ? () => _showMenu(item, i)
              : null,
        ),
      );
    }

    return Padding(
      padding: itemsSpacing,
      child: Flex(
        direction: widget.navAxis,
        mainAxisSize: MainAxisSize.min,
        children: itemsMenu,
      ),
    );
  }

  Widget _createNavItems(EdgeInsets itemsSpacing, NavThemeData navThemeData) {
    return Padding(
      padding: itemsSpacing,
      child: NavGroup(
        navWidgets: widget.navAxis == Axis.horizontal
            ? (context, index) => Text(widget.items[index].title ?? '')
            : (context, index) => Icon(widget.items[index].icon),
        axis: widget.navAxis,
        enabled: _menuIndex == -1,
        navItems: widget.items,
        index: _controller.index,
        onChanged: (value) => _indexChanged(value),
      ),
    );
  }

  void _goBack() {
    if (_menuIndex != -1) {
      _hideMenu();
    } else {
      widget.onPressBackButton!();
    }
  }

  Widget _createNavBar() {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final NavThemeData navThemeData = NavTheme.of(context);

    final backgroundColor = colorScheme.background[0];

    BoxConstraints constraints;
    EdgeInsets itemsSpacing;

    if (widget.navAxis == Axis.horizontal) {
      constraints = BoxConstraints.tightFor(height: navThemeData.height);
      itemsSpacing =
          EdgeInsets.symmetric(horizontal: navThemeData.itemsSpacing!);
    } else {
      constraints = BoxConstraints.tightFor(width: navThemeData.width);
      itemsSpacing = EdgeInsets.symmetric(vertical: navThemeData.itemsSpacing!);
    }

    final navList = <Widget>[];

    if (widget.onPressBackButton != null) {
      final enabled = (widget.isBackButtonEnabled ?? true) || _menuIndex != -1;

      final value = Container(
        alignment: Alignment.center,
        padding: itemsSpacing,
        child: NavMenuButton(
          const Icon(Icons.arrowBack),
          axis: widget.navAxis,
          active: false,
          onPressed: enabled ? () => _goBack() : null,
          tooltip: 'Back',
        ),
      );

      navList.add(value);
    }

    navList.add(
      _createNavItems(itemsSpacing, navThemeData),
    );

    navList.add(const Spacer());

    if (widget.trailingMenu.isNotEmpty) {
      navList.add(_createMenuItems(
        itemsSpacing,
        navThemeData,
        _trailingMenu,
      ));
    }

    Widget result = Container(
      constraints: constraints,
      color: backgroundColor,
      child: Flex(
        direction: widget.navAxis,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: navList,
      ),
    );

    result = ButtonTheme.merge(
      data: ButtonThemeData(
        height: navThemeData.height,
        iconThemeData: navThemeData.iconThemeData,
        color: colorScheme.shade[60],
      ),
      child: result,
    );

    return result;
  }

  @override
  void initState() {
    super.initState();

    // TODO(as): See why this is not behaving as expected.
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

    _createAnimation();

    _updateNavController();
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
                    ? (context) => widget.items[index].builder(context, index)
                    : (context) => Container(),
              ),
            ),
          );
        });
  }

  @override
  void didUpdateWidget(Nav oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
          widget.items.length - _shouldBuildView.length, false));

      for (int index = _overlays.length;
          index < widget.items.length - _shouldBuildView.length;
          index += 1) {
        _overlays.add(_createPageOverlayEntry(index));
      }
    } else {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);

      for (final overlayEntry
          in _overlays.getRange(widget.items.length, _overlays.length)) {
        overlayEntry.remove();
      }

      _overlays.removeRange(widget.items.length, _overlays.length);
    }

    if (oldWidget.navAxis != widget.navAxis) {
      _createAnimation();
    }

    if (widget.controller != oldWidget.controller) {
      _updateNavController(oldWidget.controller);
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

    _menuController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Axis navAxis = widget.navAxis;

    Widget result = Flex(
      direction: flipAxis(navAxis),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (widget.visible) _createNavBar(),
        Expanded(
          child: Overlay(
            key: _overlayKey,
            initialEntries: _overlays,
          ),
        ),
      ],
    );

    result = TabScope(
      axis: widget.navAxis,
      currentIndex: _controller.index,
      child: result,
    );

    result = NavContext._(state: this, child: result);

    return result;
  }
}
