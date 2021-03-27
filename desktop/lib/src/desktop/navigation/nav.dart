import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import '../icons.dart';
import '../input/button_icon.dart';

import 'nav_view.dart';
import 'nav_scope.dart';
import 'nav_button.dart';
export 'nav_view.dart' show NavMenuRoute;
export 'nav_scope.dart' show NavigationScope, RouteBuilder;

const int _kIntialIndexValue = 0;

class NavItem {
  const NavItem({
    required this.builder,
    required this.title,
    required this.route,
    required this.icon,
  });

  final WidgetBuilder builder;
  final IconData icon;
  final String title;
  final String route;
}

class Nav extends StatefulWidget {
  const Nav({
    Key? key,
    required this.items,
    this.back = !kIsWeb,
    this.navAxis = Axis.vertical,
    this.trailingMenu,
    this.leadingMenu,
  })  : //assert(back != null && back != kIsWeb),
        assert(items.length > 0),
        super(key: key);

  final List<NavItem> items;

  final List<NavItem>? trailingMenu;

  final List<NavItem>? leadingMenu;

  final bool back;

  final Axis navAxis;

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _index = _kIntialIndexValue;

  int get _length => widget.items.length;

  final Set<String> _menus = <String>{};

  // static final Map<LocalKey, ActionFactory> _actions =
  //     <LocalKey, ActionFactory>{
  //   NextFocusAction.key: () => NextFocusViewAction(),
  //   PreviousFocusAction.key: () => PreviousFocusViewAction(),
  // };

  bool _isBack = false;

  NavigatorState get _currentNavigator => _navigators[_index].currentState!;

  final List<FocusScopeNode> _focusNodes =
      List<FocusScopeNode>.empty(growable: true);
  final List<FocusScopeNode> _disposedFocusNodes =
      List<FocusScopeNode>.empty(growable: true);
  final List<bool> _shouldBuildView = List<bool>.empty(growable: true);
  final List<GlobalKey<NavigatorState>> _navigators =
      List<GlobalKey<NavigatorState>>.empty(growable: true);

  void _closeItem() {
    if (_menus.isEmpty) {
    } else {
      assert(_currentNavigator.canPop());
      _currentNavigator.pop();
    }
  }

  void _nextView() => _indexChanged((_index + 1) % _length);

  void _previousView() => _indexChanged((_index - 1) % _length);

  // void _requestViewFirstFocus() {
  //   FocusNode focusedNode = _currentNavigator.focusScopeNode.focusedChild ??
  //       _currentNavigator.focusScopeNode;

  //   if (focusedNode.traversalDescendants.isEmpty) return;

  //   focusedNode.requestFocus(
  //       focusedNode.traversalDescendants.whereType<FocusNode>().first);
  // }

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 ||
          index >= _length ||
          _menus.isNotEmpty ||
          Navigator.of(context, rootNavigator: true).canPop()) return false;

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
      NavigatorState navigatorState = _currentNavigator;

      bool value = navigatorState.canPop();

      if (value != _isBack) {
        setState(() => _isBack = value);
      }
    }
  }

  void _goBack() {
    NavigatorState navigatorState = _currentNavigator;

    if (_isBack) {
      navigatorState.pop();
    } else if (_index != _kIntialIndexValue) {
      setState(() {
        _index = _kIntialIndexValue;
        _isBack = _currentNavigator.canPop();
      });
    }
  }

  Future<void> _showMenu(String name) async {
    if (_menus.isEmpty) {
      setState(() => _menus.add(name));

      await _currentNavigator.pushNamed<dynamic>(name).then((_) {
        setState(() => _menus.clear());
      });
    } else {
      _currentNavigator.pop();
    }
  }

  Widget _createMenuItems(
      EdgeInsets itemsSpacing, NavThemeData navThemeData, List<NavItem> items) {
    return Padding(
      padding: itemsSpacing,
      child: Flex(
        direction: widget.navAxis,
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (item) => IconButton(
                item.icon,
                onPressed: _menus.isEmpty || _menus.contains(item.route)
                    ? () async => await _showMenu(item.route)
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _createBackMenu(EdgeInsets itemsSpacing, NavThemeData navThemeData) {
    return IconButton(
      Icons.arrow_back,
      onPressed:
          _isBack || _index != _kIntialIndexValue ? () => _goBack() : null,
      tooltip: 'Back',
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
        enabled: _menus.isEmpty,
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

    //final backgroundColor = navThemeData.background;

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

    Widget result = ConstrainedBox(
      constraints: constraints,
      child: Flex(
        direction: widget.navAxis,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.back) _createBackMenu(itemsSpacing, navThemeData),
          if (widget.leadingMenu != null && widget.leadingMenu!.length > 0)
            _createMenuItems(itemsSpacing, navThemeData, widget.leadingMenu!),
          _createNavItems(itemsSpacing, navThemeData),
          Spacer(),
          if (widget.trailingMenu != null && widget.trailingMenu!.length > 0)
            _createMenuItems(itemsSpacing, navThemeData, widget.trailingMenu!)
        ],
      ),
    );

    result = ButtonTheme(
      data: ButtonThemeData(
        // FIXME buttonPadding: widget.navAxis == Axis.vertical ? EdgeInsets.zero : null,
        height: navThemeData.height,
        bodyPadding: EdgeInsets.zero,
        iconThemeData: navThemeData.iconThemeData,
        color: colorScheme.shade4,
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

    _navigators.addAll(List<GlobalKey<NavigatorState>>.generate(
        _length, (_) => GlobalKey<NavigatorState>()));
    _shouldBuildView.addAll(List<bool>.filled(_length, false));
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
    for (var focusNode in _focusNodes) focusNode.dispose();
    for (var focusNode in _disposedFocusNodes) focusNode.dispose();

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
                    ? NavigationView(
                        builder: widget.items[index].builder,
                        //name: widget.navItems[index].route,
                        navigatorKey: _navigators[index],
                        navigatorObserver: _NavObserver(this),
                        menuRouteBuilder: (context, settings) {
                          return NavMenuRoute(
                            axis: widget.navAxis,
                            settings: settings,
                            pageBuilder: (context) =>
                                widget.trailingMenu!.first.builder(context),
                          );
                        },
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

    return NavigationScope(
      navigatorKey: _navigators[_index],
      navAxis: widget.navAxis,
      child: result,
    );
  }
}

class _NavObserver extends NavigatorObserver {
  _NavObserver(this._navState);

  _NavState _navState;

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
