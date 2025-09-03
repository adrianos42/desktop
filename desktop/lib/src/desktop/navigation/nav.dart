import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../theme/theme.dart';
import 'floating_menu_bar.dart';
import 'nav_button.dart';
import 'tab_scope.dart';

export 'tab_scope.dart' show TabScope;

class NavItem {
  const NavItem({
    required this.builder,
    required this.title,
    this.iconBuilder,
    this.titleBuilder,
  });

  /// Page builder.
  final IndexedWidgetBuilder builder;

  /// Icon used if the nav axis is vertical.
  final WidgetBuilder? iconBuilder;

  /// A widget that replaces the title when the nav is expanded.
  final WidgetBuilder? titleBuilder;

  /// The page title.
  final String title;
}

class NavMenuItem {
  const NavMenuItem({
    required this.builder,
    required this.icon,
    this.title,
    this.titleBuilder,
    this.enabled = true,
    this.axis,
  });

  /// An icon to be built for the menu.
  final WidgetBuilder icon;

  /// A title to be display when the nav is extended.
  final String? title;

  /// A widget that replaces the title when the nav is expanded.
  final WidgetBuilder? titleBuilder;

  /// The widget builder for the menu view.
  final WidgetBuilder builder;

  final AxisDirection? axis;

  final bool enabled;
}

class NavInfoItem {
  const NavInfoItem({
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
  NavController({int initialIndex = 0})
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

class NavContext extends InheritedWidget {
  const NavContext._({required super.child, required _NavState state})
    : _state = state;

  final _NavState _state;

  int get index => _state._controller.index;
  set index(int value) {
    _state._controller.index = value;
  }

  int get menuIndex => _state.menuIndex;
  set menuIndex(int value) {
    _state._showMenu(
      value,
      false,
      _state.widget.navAxis == Axis.horizontal
          ? AxisDirection.down
          : AxisDirection.right,
    );
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
  const Nav._({
    super.key,
    required this.items,
    this.navAxis = Axis.vertical,
    this.trailingMenu = const [],
    this.onPressBackButton,
    this.isBackButtonEnabled,
    this.visible = true,
    this.controller,
    this.navbarGestures,
    this.navbarWidget,
    this.compact = false,
    this.infoItems = const [],
    this.contentMenu,
  }) : assert(items.length > 0),
       assert(!compact || navAxis == Axis.vertical),
       assert(navbarWidget == null || (!compact && navAxis == Axis.vertical)),
       assert(navbarGestures == null || navAxis == Axis.horizontal);

  factory Nav.horizontal({
    Key? key,
    required List<NavItem> items,
    List<NavMenuItem> trailingMenu = const [],
    List<NavInfoItem> infoItems = const [],
    VoidCallback? onPressBackButton,
    bool? isBackButtonEnabled,
    NavController? controller,
    Map<Type, GestureRecognizerFactory>? navbarGestures,
    WidgetBuilder? contentMenu,
  }) {
    return Nav._(
      items: items,
      trailingMenu: trailingMenu,
      controller: controller,
      isBackButtonEnabled: isBackButtonEnabled,
      key: key,
      navAxis: Axis.horizontal,
      navbarGestures: navbarGestures,
      onPressBackButton: onPressBackButton,
      visible: true,
      contentMenu: contentMenu,
      infoItems: infoItems,
    );
  }

  factory Nav.vertical({
    Key? key,
    required List<NavItem> items,
    List<NavMenuItem> trailingMenu = const [],
    VoidCallback? onPressBackButton,
    bool? isBackButtonEnabled,
    NavController? controller,
    bool visible = true,
    WidgetBuilder? navbarWidget,
    WidgetBuilder? contentMenu,
  }) {
    return Nav._(
      items: items,
      trailingMenu: trailingMenu,
      controller: controller,
      isBackButtonEnabled: isBackButtonEnabled,
      key: key,
      navAxis: Axis.vertical,
      onPressBackButton: onPressBackButton,
      visible: visible,
      navbarWidget: navbarWidget,
      compact: false,
      contentMenu: contentMenu,
    );
  }

  factory Nav.compact({
    Key? key,
    required List<NavItem> items,
    List<NavMenuItem> trailingMenu = const [],
    VoidCallback? onPressBackButton,
    bool? isBackButtonEnabled,
    NavController? controller,
    WidgetBuilder? contentMenu,
  }) {
    return Nav._(
      items: items,
      trailingMenu: trailingMenu,
      controller: controller,
      isBackButtonEnabled: isBackButtonEnabled,
      key: key,
      navAxis: Axis.vertical,
      onPressBackButton: onPressBackButton,
      visible: true,
      compact: true,
      contentMenu: contentMenu,
    );
  }

  /// The items with builder and route names for transition among pages.
  final List<NavItem> items;

  /// Info after the navigation items.
  final List<NavInfoItem> infoItems;

  /// Menu after the navigation items.
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

  /// If the nav bar should be visible.
  final bool compact;

  final WidgetBuilder? navbarWidget;

  /// A widget that's above all pages. Usually used for [FloatingMenuBar].
  final WidgetBuilder? contentMenu;

  /// Controls selected index.
  final NavController? controller;

  static NavContext? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavContext>();

  final Map<Type, GestureRecognizerFactory>? navbarGestures;

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav>
    with SingleTickerProviderStateMixin, NavMenuMixin {
  int get _length => widget.items.length;

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

  OverlayEntry? _contentOverlay;

  List<NavMenuItem> get _trailingMenu => widget.trailingMenu.reversed.toList();

  List<NavInfoItem> get _infoItems => widget.infoItems.reversed.toList();

  late Duration _menuTransitionDuration;
  late Curve _menuTrasitionCurve;
  late Color _navBarBackgroundColor;

  @override
  OverlayState get overlay => _overlayKey.currentState!;

  @override
  Duration get menuTransitionDuration => _menuTransitionDuration;

  @override
  Curve get menuTransitionCurve => _menuTrasitionCurve;

  @override
  Color get navBarBackgroundColor => _navBarBackgroundColor;

  @override
  Color get barrierColor => DialogTheme.of(context).barrierColor!;

  @override
  ImageFilter get filter => DialogTheme.of(context).imageFilter!;

  void nextView() => _indexChanged((_controller.index + 1) % _length);

  void previousView() => _indexChanged((_controller.index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _controller.index) {
      if (index < 0 || index >= _length || menuIndex != -1) {
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

  void _showMenu(int index, bool isInfoMenu, AxisDirection axis) {
    final builders = [
      ..._infoItems.map((e) => e.builder),
      ..._trailingMenu.map((e) => e.builder),
    ];

    setState(() {
      showMenu(index, axis: axis, builders: builders, isInfoMenu: isInfoMenu);
    });
  }

  void _onCurrentIndexChange() {
    assert(_controller.index >= 0 && _controller.index < _length);
    setState(() {});
  }

  void _handleMenuAnimationStatusChanged(AnimationStatus status) =>
      setState(() => handleMenuAnimationStatusChanged(status));

  Widget _createMenuItems(
    EdgeInsets itemSpacing,
    NavThemeData navThemeData,
    List<NavMenuItem> items,
  ) {
    final List<Widget> itemsMenu = List<Widget>.empty(growable: true);

    for (int i = items.length - 1; i >= 0; i -= 1) {
      final NavMenuItem item = items[i];

      final int index = i + widget.infoItems.length;
      final bool enabled = !menuShown || menuIndex == index;
      final axis =
          item.axis ??
          (widget.navAxis == Axis.horizontal
              ? AxisDirection.up
              : AxisDirection.left);

      itemsMenu.add(
        NavMenuButton(
          item.icon(context),
          axis: widget.navAxis,
          active: menuIndex == index,
          onPressed: () => _showMenu(index, false, axis),
          titleBuilder: item.titleBuilder,
          title: item.title,
          enabled: item.enabled && enabled,
          compact: widget.compact || widget.navAxis == Axis.horizontal,
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(minWidth: navThemeData.width!),
      child: Flex(
        direction: widget.navAxis,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: itemsMenu,
      ),
    );
  }

  Widget _createInfoItems(
    EdgeInsets itemSpacing,
    NavThemeData navThemeData,
    List<NavInfoItem> items,
  ) {
    final List<Widget> itemsMenu = List<Widget>.empty(growable: true);

    final bool enabled = menuIndex < widget.infoItems.length;

    for (int i = items.length - 1; i >= 0; i -= 1) {
      final NavInfoItem item = items[i];

      itemsMenu.add(
        NavMenuButton(
          item.icon(context),
          axis: Axis.horizontal,
          active: menuIndex == i,
          onHover: () {
            if (menuIndex != i || menuController!.isAnimating) {
              _showMenu(i, true, AxisDirection.up);
            }
          },
          onHoverEnd: () => setState(hideMenu),
          compact: true,
          enabled: items[i].enabled && enabled,
        ),
      );
    }

    return MouseRegion(
      onExit: enabled
          ? (event) {
              if (event.localPosition.dy < navThemeData.height!) {
                setState(hideMenu);
              }
            }
          : null,
      hitTestBehavior: HitTestBehavior.translucent,
      opaque: false,
      child: Container(
        constraints: BoxConstraints(minWidth: navThemeData.width!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: itemsMenu,
        ),
      ),
    );
  }

  void _goBack() {
    if (menuIndex != -1) {
      setState(hideMenu);
    } else {
      widget.onPressBackButton!();
    }
  }

  Widget _createHorizontalItems(
    EdgeInsets itemSpacing,
    NavThemeData navThemeData,
  ) {
    return Padding(
      padding: itemSpacing,
      child: NavGroupHorizontal(
        navWidgets: (context, index) => Text(widget.items[index].title),
        enabled: !menuShown,
        navItems: widget.items,
        index: _controller.index,
        onChanged: (value) => _indexChanged(value),
      ),
    );
  }

  Widget _createVerticalItems(
    EdgeInsets itemSpacing,
    NavThemeData navThemeData,
  ) {
    return Padding(
      padding: itemSpacing,
      child: NavGroupVertical(
        compact: widget.compact,
        enabled: !menuShown,
        navItems: widget.items,
        index: _controller.index,
        onChanged: (value) => _indexChanged(value),
      ),
    );
  }

  Widget _createVerticalBar() {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final NavThemeData navThemeData = NavTheme.of(context);

    final backgroundColor = colorScheme.background[0];

    final BoxConstraints constraints = BoxConstraints(
      minWidth: navThemeData.width!,
      //maxWidth: 400.0,
    );

    final EdgeInsets itemSpacing = EdgeInsets.symmetric(
      vertical: navThemeData.itemSpacing!,
    );

    final navList = <Widget>[];

    if (widget.onPressBackButton != null) {
      final enabled = (widget.isBackButtonEnabled ?? true) || menuIndex != -1;

      final value = Container(
        alignment: Alignment.center,
        padding: itemSpacing,
        child: NavMenuButton(
          const Icon(Icons.arrowBack),
          axis: Axis.vertical,
          titleBuilder: null,
          active: false,
          enabled: true,
          title: 'Back',
          onPressed: enabled ? () => _goBack() : null,
        ),
      );

      navList.add(value);
    }

    navList.add(_createVerticalItems(itemSpacing, navThemeData));

    if (widget.navbarWidget != null) {
      navList.add(Expanded(child: widget.navbarWidget!(context)));
    } else {
      navList.add(const Spacer());
    }

    if (widget.trailingMenu.isNotEmpty) {
      navList.add(_createMenuItems(itemSpacing, navThemeData, _trailingMenu));
    }

    return Container(
      constraints: constraints,
      color: backgroundColor,
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: navList,
        ),
      ),
    );
  }

  Widget _createHorizontalBar() {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final NavThemeData navThemeData = NavTheme.of(context);

    final backgroundColor = colorScheme.background[0];

    final BoxConstraints constraints = BoxConstraints.tightFor(
      height: navThemeData.height,
    );
    final EdgeInsets itemSpacing = EdgeInsets.symmetric(
      horizontal: navThemeData.itemSpacing!,
    );

    final navList = <Widget>[];

    if (widget.onPressBackButton != null) {
      final enabled = (widget.isBackButtonEnabled ?? true) || menuIndex != -1;

      final value = Container(
        alignment: Alignment.center,
        padding: itemSpacing,
        child: NavMenuButton(
          const Icon(Icons.arrowBack),
          axis: Axis.horizontal,
          titleBuilder: null,
          active: false,
          enabled: true,
          onPressed: enabled ? () => _goBack() : null,
          title: 'Back',
        ),
      );

      navList.add(value);
    }

    navList.add(_createHorizontalItems(itemSpacing, navThemeData));

    if (widget.navbarGestures != null) {
      navList.add(
        Expanded(
          child: RawGestureDetector(
            gestures: widget.navbarGestures!,
            behavior: HitTestBehavior.opaque,
          ),
        ),
      );
    } else {
      navList.add(const Spacer());
    }

    if (widget.infoItems.isNotEmpty) {
      navList.add(
        Padding(
          padding: EdgeInsets.only(
            right: widget.trailingMenu.isNotEmpty
                ? navThemeData.itemSpacing!
                : 0.0,
          ),
          child: _createInfoItems(itemSpacing, navThemeData, _infoItems),
        ),
      );
    }

    if (widget.trailingMenu.isNotEmpty) {
      navList.add(_createMenuItems(itemSpacing, navThemeData, _trailingMenu));
    }

    Widget result = Container(
      constraints: constraints,
      color: backgroundColor,
      child: Row(
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
      },
    );
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

    _overlays.addAll(
      List<OverlayEntry>.generate(
        _length,
        (index) => _createPageOverlayEntry(index),
      ),
    );

    if (widget.contentMenu != null) {
      _contentOverlay = OverlayEntry(
        builder: (context) => widget.contentMenu!(context),
      );
    }

    _updateNavController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final NavThemeData themeData = NavTheme.of(context);

    _menuTransitionDuration = themeData.menuTransitionDuration!;
    _menuTrasitionCurve = themeData.menuTrasitionCurve!;
    _navBarBackgroundColor = themeData.navBarBackgroundColor!;

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
  void didUpdateWidget(Nav oldWidget) {
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
    } else {
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

    if (oldWidget.contentMenu != widget.contentMenu) {
      if (widget.contentMenu == null) {
        _contentOverlay?.remove();
        _contentOverlay = null;
      } else {
        _contentOverlay = OverlayEntry(
          builder: (context) => widget.contentMenu!(context),
        );
      }
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

    menuController?.removeStatusListener(_handleMenuAnimationStatusChanged);
    menuController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Axis navAxis = widget.navAxis;

    final overlays = [..._overlays];
    if (_contentOverlay != null) {
      overlays.add(_contentOverlay!);
    }

    Widget result = Flex(
      direction: flipAxis(navAxis),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (widget.visible && widget.navAxis == Axis.vertical)
          _createVerticalBar(),
        if (widget.visible && widget.navAxis == Axis.horizontal)
          _createHorizontalBar(),
        Expanded(
          child: Overlay(key: _overlayKey, initialEntries: overlays),
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
