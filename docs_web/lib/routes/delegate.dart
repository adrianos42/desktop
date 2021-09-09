import 'package:flutter/foundation.dart';
import 'package:desktop/desktop.dart';
import '../home.dart';

class DocsRouteDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final _pages = <Page>[];

  DocsRouteDelegate() {
    _pages.add(_createPage(RouteSettings(name: '/')));
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    popRoute();

    return true;
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();

      return Future.value(true);
    }

    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {
    _setPath(configuration
        .map((routeSettings) => _createPage(routeSettings))
        .toList());

    return Future.value(null);
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);

    if (pages.first.name != '/') {
      _pages.insert(0, _createPage(RouteSettings(name: '/')));
    }

    notifyListeners();
  }

  DesktopPage _createPage(RouteSettings routeSettings) {
    Widget child;

    switch (routeSettings.name) {
      case '/':
        child = DocApp();
        break;
      default:
        child = Center(
          child: Text('Page not found'),
        );
    }

    return DesktopPage(
      child: child,
      key: ValueKey(routeSettings.name),
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  // @override
  // void pushPage({required String name, required dynamic arguments}) {
  //   _pages.add(_createPage(name: name, arguments: arguments));

  //   notifyListeners();
  // }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }
}

class DocsInformationParser
    extends RouteInformationParser<List<RouteSettings>> {
  const DocsInformationParser() : super();

  @override
  SynchronousFuture<List<RouteSettings>> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture([RouteSettings(name: '/')]);
    }

    final routeSettings = uri.pathSegments
        .map((pathSegment) => RouteSettings(
            name: '/$pathSegment',
            arguments: pathSegment == uri.pathSegments.last
                ? uri.queryParameters
                : null))
        .toList();

    return SynchronousFuture(routeSettings);
  }

  @override
  RouteInformation restoreRouteInformation(List<RouteSettings> configuration) {
    final location = configuration.last.name;
    return RouteInformation(location: '$location');
  }
}
