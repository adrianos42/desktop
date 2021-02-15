import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'route.dart';

import '../theme/theme.dart';
import '../input/button_text.dart';
import '../icons.dart';

import 'nav_scope.dart' show RouteBuilder;

typedef TextCallback = void Function(String);

const double _kHeight = 32.0;
const EdgeInsets _khorizontalPadding = EdgeInsets.symmetric(horizontal: 16.0);

class Breadcrumb extends StatefulWidget {
  const Breadcrumb({
    Key? key,
    required this.routeBuilder,
    required this.initialRoute,
    this.routeNameChanged,
    this.trailing,
  }) : super(key: key);

  final String initialRoute;

  final TextCallback? routeNameChanged;

  final RouteBuilder routeBuilder;

  final Widget? trailing;

  @override
  _BreadcrumbState createState() => _BreadcrumbState();
}

class _BreadcrumbState extends State<Breadcrumb> {
  late GlobalKey<NavigatorState> _navigatorKey;

  List<String> _names = List<String>.empty(growable: true);

  void _pushName(String name) {
    if (mounted) {
      name = _formatNavText(name);

      widget.routeNameChanged?.call(name);
      setState(() => _names.add(name));
    }
  }

  void _popName() {
    if (mounted) {
      var names = _names;
      assert(names.length > 1, "Cannot pop the first route");

      names.removeLast();
      widget.routeNameChanged?.call(names.last);

      _names = names;

      setState(() {});
    }
  }

  void _popByIndex(int index) {
    var names = _names;

    while (names.length - 1 > index) {
      names.removeAt(names.length - 1);
      assert(_navigatorKey.currentState!.canPop());

      _navigatorKey.currentState!.pop();
    }

    widget.routeNameChanged?.call(_names.last);

    setState(() => _names = names);
  }

  String _formatNavText(String value) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return capitalize(value.replaceAll('/', '').replaceAll('_', ' '));
  }

  Widget _createBarNavigation() {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;

    var items = List<Widget>.empty(growable: true);

    for (int i = 0; i < _names.length; i++) {
      var isLast = i == _names.length - 1;

      if (i > 0 && 1 < _names.length) {
        items.add(
          Center(
            child: Icon(
              Icons.chevron_right,
              color: textTheme.textLow.toColor(),
              size: 20.0,
            ),
          ),
        );
      }

      items.add(
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            _names[i],
            // hoveredForeground: textTheme.textHigh,
            // activeForeground: textTheme.textLow,
            // pressedForeground: textTheme.textHigh,
            // disabledForeground: textTheme.textHigh,
            onPressed: isLast ? null : () => _popByIndex(i),
          ),
        ),
      );
    }

    Widget result = Container(
      constraints: BoxConstraints.tightFor(height: _kHeight),
      color: Theme.of(context).colorScheme.background.toColor(),
      child: Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );

    return result;
  }

  @override
  void initState() {
    super.initState();

    var name = _formatNavText(widget.initialRoute);

    _names.add(name);

    _navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Breadcrumb oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _createBarNavigation(),
        Expanded(
          child: Builder(
            builder: (context) => _NavigationView(
              builder: widget.routeBuilder,
              navigatorKey: _navigatorKey,
              initialRoute: widget.initialRoute,
              navigatorObserver: _NavObserver(this),
            ),
          ),
        ),
      ],
    );

    return result;
  }
}

class _NavObserver extends NavigatorObserver {
  _NavObserver(this._navState);

  _BreadcrumbState _navState;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (!route.isFirst && route is PageRoute<dynamic>) {
      _navState._pushName(route.settings.name!); // FIXME
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute<dynamic>) {}
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}

class _TabGroup extends StatefulWidget {
  const _TabGroup({
    Key? key,
    required this.index,
    required this.items,
    required this.changeIndex,
    this.trailing,
  }) : super(key: key);

  final int index;

  final List<String> items;

  final ValueChanged<int> changeIndex;

  final Widget? trailing;

  @override
  _TabGroupState createState() => _TabGroupState();
}

class _TabGroupState extends State<_TabGroup> {
  late int _hoveredIndex;
  late int _pressedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(_TabGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    List<Widget> list = List<Widget>.generate(widget.items.length, (index) {
      final HSLColor foreground =
          widget.index == index || _pressedIndex == index
              ? colorScheme.primary
              : _hoveredIndex == index
                  ? textTheme.textMedium
                  : textTheme.textLow;

      final TextStyle textStyle =
          textTheme.body2.copyWith(color: foreground.toColor());

      return Padding(
        padding: EdgeInsets.only(
          right: 22.0,
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = index),
          onExit: (_) => setState(() => _hoveredIndex = -1),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => setState(() => _pressedIndex = index),
            onTapUp: (_) => setState(() => _pressedIndex = -1),
            onTapCancel: () => setState(() => _pressedIndex = -1),
            onTap: () => widget.changeIndex(index),
            child: Text(
              widget.items[index],
              style: textStyle,
            ),
          ),
        ),
      );
    });

    Widget result = Container(
      height: _kHeight,
      color: colorScheme.background.toColor(),
      child: Padding(
        padding: _khorizontalPadding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ...list,
            Spacer(),
            if (widget.trailing != null) widget.trailing!, // FIXME
          ],
        ),
      ),
    );

    return result;
  }
}

class _NavigationView extends StatefulWidget {
  const _NavigationView({
    required this.builder,
    this.initialRoute,
    this.navigatorKey,
    required this.navigatorObserver,
    Key? key,
  }) : super(key: key);

  final RouteBuilder builder;

  final GlobalKey<NavigatorState>? navigatorKey;

  final String? initialRoute;

  final NavigatorObserver navigatorObserver;

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<_NavigationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      initialRoute: widget.initialRoute,
      observers: <NavigatorObserver>[widget.navigatorObserver],
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    return widget.builder(context, settings);
  }

  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    final name = settings.name!.replaceFirst(r'/', '');

    ThemeData themeData = Theme.invertedThemeOf(context);

    return DesktopPageRoute(
      builder: (context) => Container(
        alignment: Alignment.center,
        color: themeData.colorScheme.background.toColor(),
        child: Text(
          'Page "$name" not found',
          style: themeData.textTheme.title,
        ),
      ),
      settings: settings,
    );
  }
}
