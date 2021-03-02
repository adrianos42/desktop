import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef RouteBuilder = Route<dynamic> Function(BuildContext, RouteSettings);

class NavigationScope extends InheritedWidget {
  const NavigationScope({
    Key? key,
    required Widget child,
    required this.navAxis,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _navigatorKey = navigatorKey,
        super(key: key, child: child);

  final GlobalKey<NavigatorState> _navigatorKey;

  NavigatorState? get navigatorState => _navigatorKey.currentState;

  final Axis navAxis;

  @override
  bool updateShouldNotify(NavigationScope old) => true;

  static NavigationScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavigationScope>();
}