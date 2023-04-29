import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'route.dart';
import 'tab_route.dart';
import 'tab_scope.dart';

/// A tab view with a [Navigator] history.
class TabView extends StatefulWidget {
  ///
  const TabView({
    this.builder,
    this.navigatorKey,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.defaultTitle,
    this.navigatorObservers = const <NavigatorObserver>[],
    super.key,
  });

  /// The widget builder for the default route of the tab view
  /// ([Navigator.defaultRouteName], which is `/`).
  ///
  /// If a [builder] is specified, then [routes] must not include an entry for `/`,
  /// as [builder] takes its place.
  final WidgetBuilder? builder;

  /// The navigator key.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// The title of the default route.
  final String? defaultTitle;

  /// This tab view's routing table.
  ///
  /// This routing table is not shared with any routing tables of ancestor or
  /// descendant [Navigator]s.
  final Map<String, WidgetBuilder>? routes;

  /// The route generator callback used when the tab view is navigated to a named route.
  final RouteFactory? onGenerateRoute;

  /// Called when [onGenerateRoute] also fails to generate a route.
  final RouteFactory? onUnknownRoute;

  /// The list of observers for the [Navigator] created in this tab view.
  final List<NavigatorObserver> navigatorObservers;

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      observers: widget.navigatorObservers,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    WidgetBuilder? routeBuilder;

    if (name == Navigator.defaultRouteName && widget.builder != null) {
      routeBuilder = widget.builder;
    } else if (widget.routes != null) {
      routeBuilder = widget.routes![name];
    }

    if (routeBuilder != null) {
      return DesktopPageRoute<dynamic>(
        builder: routeBuilder,
        settings: settings,
      );
    }

    return widget.onGenerateRoute?.call(settings);
  }

  Route<dynamic>? _onUnknownRoute(RouteSettings settings) {
    if (widget.onUnknownRoute != null) {
      return widget.onUnknownRoute!(settings);
    }

    final ThemeData themeData = Theme.of(context);

    return TabMenuRoute<dynamic>(
      context: context,
      barrierColor: themeData.colorScheme.background[0],
      axis: TabScope.of(context)!.axis,
      pageBuilder: (BuildContext context) => Container(
        alignment: Alignment.center,
        color: themeData.colorScheme.background[0],
        child: Text(
          'Page "${settings.name}" not found',
          style: themeData.textTheme.title,
        ),
      ),
      settings: settings,
    );
  }
}
