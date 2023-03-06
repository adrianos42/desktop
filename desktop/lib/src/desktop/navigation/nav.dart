import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../theme/theme.dart';
import 'nav_button.dart';
import 'tab_scope.dart';

export 'tab_scope.dart' show TabScope;

const int _kIntialIndexValue = 0;

const Duration _kMenuTransitionDuration = Duration(milliseconds: 300);

class NavItem {
  const NavItem({
    required this.builder,
    required this.title,
    required this.icon,
  });

  /// Page builder.
  final IndexedWidgetBuilder builder;

  /// Icon used if the nav axis is vertical.
  final IconData icon;

  /// The title shown in case the nav axis is horizontal.
  final String title;
}

/// Navigation widget [Nav]...
///
///```dart
/// Nav(
///   trailingMenu: [
///     NavItem(
///       title: 'home',
///       builder: (context) => NavDialog(
///         child: Container(
///           alignment: Alignment.center,
///           padding: EdgeInsets.all(32.0),
///           width: 600.0,
///           child: Text('Home page'),
///         ),
///       ),
///       icon: Icons.home,
///     ),
///     NavItem(
///       title: 'settings',
///       builder: (context) => NavDialog(
///         child: Container(
///           alignment: Alignment.center,
///           padding: EdgeInsets.all(32.0),
///           width: 600.0,
///           child: Text('Settings page'),
///         ),
///       ),
///       icon: Icons.settings,
///     ),
///   ],
///   items: [
///     NavItem(
///       builder: (context) => Center(child: Text('page1')),
///       title: 'page1',
///       icon: Icons.today,
///     ),
///     NavItem(
///       builder: (context) => Center(child: Text('page2')),
///       title: 'page2',
///       icon: Icons.stars,
///     ),
///     NavItem(
///       builder: (context) => Center(child: Text('page3')),
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
    this.trailingMenu,
    this.onPressBackButton,
    this.isBackButtonEnabled,
    this.visible = true,
  })  : assert(items.length > 0);

  /// The items with builder and route names for transition among pages.
  final List<NavItem> items;

  /// Menu before the navigation items.
  final List<NavItem>? trailingMenu;

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

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> with SingleTickerProviderStateMixin {
  int _index = _kIntialIndexValue;

  int get _length => widget.items.length;

  String? _menus;
  OverlayEntry? _menuOverlay;

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

  static const Curve _animationCurve = Curves.easeInOutSine;

  void _createAnimation() {
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: _animationCurve,
      reverseCurve: _animationCurve,
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

  void nextView() => _indexChanged((_index + 1) % _length);

  void previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 || index >= _length || _menus != null) {
        return false;
      }

      setState(() => _index = index);

      return true;
    }

    return false;
  }

  void _handleMenuAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && _menus == null) {
      _menuOverlay?.remove();
      _menuOverlay = null;
    }
  }

  void _hideMenu() {
    setState(() {
      _menus = null;
      _menuController.reverse();
    });
  }

  void _showMenu(NavItem item, int index) {
    if (_menus == null) {
      setState(() {
        _menus = item.title;

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
                  onTap: () {}, // TODO(as): Better way to do this?
                  child: ClipRect(
                    child: FractionalTranslation(
                      translation: _menuOffsetTween.evaluate(_menuAnimation),
                      child: item.builder(context, index),
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
      EdgeInsets itemsSpacing, NavThemeData navThemeData, List<NavItem> items) {
    final List<Widget> itemsMenu = List<Widget>.empty(growable: true);

    for (int i = 0; i < items.length; i += 1) {
      itemsMenu.add(
        NavMenuButton(
          Icon(items[i].icon),
          axis: widget.navAxis,
          active: _menus == items[i].title,
          onPressed: _menus == null || _menus == items[i].title
              ? () => _showMenu(items[i], i)
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
            ? (context, index) => Text(widget.items[index].title)
            : (context, index) => Icon(widget.items[index].icon),
        axis: widget.navAxis,
        enabled: _menus == null,
        navItems: widget.items,
        index: _index,
        onChanged: (value) => _indexChanged(value),
      ),
    );
  }

  void _goBack() {
    if (_menus != null) {
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
      final enabled = (widget.isBackButtonEnabled ?? true) || _menus != null;

      final value = Container(
        alignment: Alignment.center,
        padding: itemsSpacing,
        child: NavMenuButton(
          const Icon(Icons.arrow_back),
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

    if (widget.trailingMenu != null && widget.trailingMenu!.isNotEmpty) {
      navList.add(
          _createMenuItems(itemsSpacing, navThemeData, widget.trailingMenu!));
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
  }

  OverlayEntry _createPageOverlayEntry(int index) {
    return OverlayEntry(
        maintainState: true,
        builder: (context) {
          final bool active = index == _index;
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
  }

  @override
  void dispose() {
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
      currentIndex: _index,
      child: result,
    );

    return result;
  }
}
