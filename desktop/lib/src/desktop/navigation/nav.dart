import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../theme/theme.dart';
import 'nav_button.dart';
import 'tab_route.dart';
import 'tab_scope.dart';
import 'tab_view.dart';

export 'tab_scope.dart' show TabScope, RouteBuilder;

const int _kIntialIndexValue = 0;

class NavItem {
  const NavItem({
    required this.builder,
    required this.title,
    required this.route,
    required this.icon,
  });

  /// Page builder.
  final WidgetBuilder builder;

  /// Icon used if the nav axis is vertical.
  final IconData icon;

  /// The title shown in case the nav axis is horizontal.
  final String title;

  /// Unique route name for the page created with `builder`.
  final String route;
}

/// Navigation widget [Nav]...
///
///```dart
/// Nav(
///   trailingMenu: [
///     NavItem(
///       title: 'home',
///       route: '/home',
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
///       route: '/settings',
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
///       route: '/page1',
///     ),
///     NavItem(
///       builder: (context) => Center(child: Text('page2')),
///       title: 'page2',
///       route: '/page2',
///       icon: Icons.stars,
///     ),
///     NavItem(
///       builder: (context) => Center(child: Text('page3')),
///       title: 'page3',
///       route: '/page3',
///       icon: Icons.share,
///     ),
///   ],
/// )
///```
class Nav extends StatefulWidget {
  const Nav({
    Key? key,
    required this.items,
    this.backButton = !kIsWeb,
    this.navAxis = Axis.vertical,
    this.trailingMenu,
    this.leadingMenu,
    this.focusNode,
    this.autofocus = true,
  })  : assert(items.length > 0),
        super(key: key);

  /// The items with builder and route names for transition among pages.
  final List<NavItem> items;

  /// Menu before the navigation items.
  final List<NavItem>? trailingMenu;

  /// Menu after the navigation items, usually at the end of the nav bar.
  final List<NavItem>? leadingMenu;

  /// If the back button is enabled. Defaults to true in linux.
  final bool backButton;

  /// The axis of the nav bar.
  final Axis navAxis;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final bool autofocus;

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _index = _kIntialIndexValue;

  int get _length => widget.items.length;

  String? _menus;

  // static final Map<LocalKey, ActionFactory> _actions =
  //     <LocalKey, ActionFactory>{
  //   NextFocusAction.key: () => NextFocusViewAction(),
  //   PreviousFocusAction.key: () => PreviousFocusViewAction(),
  // };

  // late Map<Type, Action<Intent>> _actionMap;

  bool _isBack = false;

  NavigatorState get _currentNavigator => _navigators[_index].currentState!;

  final List<FocusScopeNode> _focusNodes =
      List<FocusScopeNode>.empty(growable: true);
  final List<FocusScopeNode> _disposedFocusNodes =
      List<FocusScopeNode>.empty(growable: true);
  final List<bool> _shouldBuildView = List<bool>.empty(growable: true);
  final List<GlobalKey<NavigatorState>> _navigators =
      List<GlobalKey<NavigatorState>>.empty(growable: true);

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  // void _nextView() => _indexChanged((_index + 1) % _length);

  // void _previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 ||
          index >= _length ||
          _menus != null ||
          Navigator.of(context, rootNavigator: true).canPop()) {
        return false;
      }

      setState(() {
        _index = index;
        _focusView();
      });

      return true;
    }

    return false;
  }

  void _updateBackButton() {
    if (mounted) {
      final bool value = _currentNavigator.canPop();

      if (value != _isBack) {
        setState(() => _isBack = value);
      }
    }
  }

  void _goBack() {
    if (_isBack) {
      _currentNavigator.maybePop();
    } else if (_index != _kIntialIndexValue) {
      setState(() {
        _index = _kIntialIndexValue;
        _isBack = _currentNavigator.canPop();
      });
    }
  }

  void _showMenu(NavItem item) {
    setState(() {
      if (_menus == null) {
        _menus = item.route;

        _currentNavigator
            .push<dynamic>(TabMenuRoute(
          context: context,
          axis: widget.navAxis,
          barrierColor: DialogTheme.of(context).barrierColor!,
          settings: RouteSettings(name: item.route),
          pageBuilder: item.builder,
        ))
            .then((_) {
          setState(() => _menus = null);
        });
      } else {
        _currentNavigator.pop();
      }
    });
  }

  Widget _createMenuItems(
      EdgeInsets itemsSpacing, NavThemeData navThemeData, List<NavItem> items) {
    return Padding(
      padding: itemsSpacing,
      child: Flex(
        direction: widget.navAxis,
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          return NavMenuButton(
            Icon(item.icon),
            axis: widget.navAxis,
            active: _menus == item.route,
            onPressed: _menus == null || _menus == item.route
                ? () => _showMenu(item)
                : null,
          );
        }).toList(),
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

  Widget _createNavBar() {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final NavThemeData navThemeData = NavTheme.of(context);

    final backgroundColor = colorScheme.background;

    BoxConstraints constraints;
    EdgeInsets itemsSpacing;

    if (widget.navAxis == Axis.horizontal) {
      constraints = BoxConstraints.tightFor(height: navThemeData.height);
      itemsSpacing =
          EdgeInsets.symmetric(horizontal: navThemeData.itemsSpacing);
    } else {
      constraints = BoxConstraints.tightFor(width: navThemeData.width);
      itemsSpacing = EdgeInsets.symmetric(vertical: navThemeData.itemsSpacing);
    }

    final navList = <Widget>[];

    if (widget.backButton) {
      final enabled = _isBack || _index != _kIntialIndexValue || _menus != null;

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

    if (widget.leadingMenu != null && widget.leadingMenu!.isNotEmpty) {
      navList.add(
        _createMenuItems(itemsSpacing, navThemeData, widget.leadingMenu!),
      );
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
      color: backgroundColor.toColor(),
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

  void _focusView() {
    if (_focusNodes.length != _length) {
      if (_length < _focusNodes.length) {
        _disposedFocusNodes.addAll(_focusNodes.sublist(_length));
        _focusNodes.removeRange(_length, _focusNodes.length);
      } else {
        _focusNodes.addAll(
          List<FocusScopeNode>.generate(
            _length - _focusNodes.length,
            (index) => FocusScopeNode(
              skipTraversal: true,
              debugLabel: 'Nav ${index + _focusNodes.length}',
            ),
          ),
        );
      }
    }

    FocusScope.of(context).setFirstFocus(_focusNodes[_index]);
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

    _navigators.addAll(List<GlobalKey<NavigatorState>>.generate(
        _length, (_) => GlobalKey<NavigatorState>()));
    _shouldBuildView.addAll(List<bool>.filled(_length, false));

    widget.leadingMenu?.forEach((element) {
      if (widget.leadingMenu!
                  .where((other) => other.route == element.route)
                  .length !=
              1 ||
          (widget.trailingMenu
                      ?.where((other) => other.route == element.route)
                      .length ??
                  0) !=
              0) {
        throw Exception('Menu item must have unique route name.');
      }
    });

    widget.trailingMenu?.forEach((element) {
      if (widget.trailingMenu!
                  .where((other) => other.route == element.route)
                  .length !=
              1 ||
          (widget.leadingMenu
                      ?.where((other) => other.route == element.route)
                      .length ??
                  0) !=
              0) {
        throw Exception('Menu item must have unique route name.');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusView();
  }

  @override
  void didUpdateWidget(Nav oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
          widget.items.length - _shouldBuildView.length, false));
    } else {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);
    }

    if (widget.items.length - _navigators.length > 0) {
      _navigators.addAll(List<GlobalKey<NavigatorState>>.generate(
          widget.items.length - _navigators.length,
          (index) => GlobalKey<NavigatorState>()));
    } else {
      _navigators.removeRange(widget.items.length, _navigators.length);
    }

    _focusView();
  }

  @override
  void dispose() {
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (final focusNode in _disposedFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = List<Widget>.generate(_length, (index) {
      final bool active = index == _index;
      _shouldBuildView[index] = active || _shouldBuildView[index];

      return Offstage(
        offstage: !active,
        child: TickerMode(
          enabled: active,
          child: FocusScope(
            node: _focusNodes[index],
            canRequestFocus: active,
            child: Builder(
              builder: (context) {
                return _shouldBuildView[index]
                    ? TabView(
                        builder: widget.items[index].builder,
                        navigatorKey: _navigators[index],
                        navigatorObservers: [_NavObserver(this)],
                      )
                    : Container();
              },
            ),
          ),
        ),
      );
    });

    final Axis navAxis = widget.navAxis;

    Widget result = Flex(
      direction: flipAxis(navAxis),
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _createNavBar(),
        Expanded(
          child: Stack(children: list),
        ),
      ],
    );

    result = TabScope(
      axis: widget.navAxis,
      currentIndex: _index,
      child: result,
    );

    return FocusableActionDetector(
      child: result,
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      onShowFocusHighlight: (_) {},
      onFocusChange: (_) {},
      // onShowHoverHighlight: (value) {
      //   if (value) {
      //     FocusScope.of(context).requestFocus(_effectiveFocusNode);
      //   }
      // },
      // actions: _actionMap,
    );
  }
}

class _NavObserver extends NavigatorObserver {
  _NavObserver(this._navState);

  final _NavState _navState;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    assert(route.navigator == _navState._currentNavigator);

    if (!route.isFirst) {
      if (route is PopupRoute<dynamic> || route is PageRoute<dynamic>) {
        _navState._updateBackButton();
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    assert(route.navigator == _navState._currentNavigator);

    if (!route.isFirst) {
      if (route is PopupRoute<dynamic> || route is PageRoute<dynamic>) {
        _navState._updateBackButton();
      }
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}
