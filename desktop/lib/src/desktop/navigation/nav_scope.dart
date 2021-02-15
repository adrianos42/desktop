import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef RouteBuilder = Route<dynamic> Function(BuildContext, RouteSettings);

class NavScope extends InheritedWidget {
  const NavScope({
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
  bool updateShouldNotify(NavScope old) => true;

  static NavScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavScope>();
}