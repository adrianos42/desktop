import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

import 'route.dart';
import 'nav_scope.dart' show NavigationScope, RouteBuilder;

class NavMenuRoute<T> extends PopupRoute<T> {
  NavMenuRoute({
    required WidgetBuilder pageBuilder,
    String? barrierLabel,
    RouteSettings? settings,
    required this.axis,
  })   : _pageBuilder = pageBuilder,
        _barrierLabel = barrierLabel,
        super(settings: settings);

  final Axis axis;

  final WidgetBuilder _pageBuilder;

  Tween<Offset>? _offsetTween;

  Animation<double>? _animation;

  static final Curve _animationCurve = Curves.easeInOut;



  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color? get barrierColor => HSLColor.fromAHSL(0.8, 0.0, 0.0, 0.1).toColor();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),
      curve: _animationCurve,
      reverseCurve: _animationCurve,
    );

    final Offset begin =
        axis == Axis.vertical ? Offset(-1.0, 0.0) : Offset(0.0, -1.0);
    final Offset end = Offset(0.0, 0.0);

    _offsetTween = Tween<Offset>(
      begin: begin,
      end: end,
    );

    return _animation!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        heightFactor: 1.0,
        child: FractionalTranslation(
          translation: _offsetTween!.evaluate(_animation!),
          child: child,
        ),
      ),
    );
  }
}

class NavigationView extends StatefulWidget {
  const NavigationView({
    required this.builder,
    this.menuRouteBuilder,
    this.navigatorKey,
    required this.navigatorObserver,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;

  final GlobalKey<NavigatorState>? navigatorKey;

  final NavigatorObserver navigatorObserver;

  final RouteBuilder? menuRouteBuilder;

  //NavigatorState get navigatorState => navigatorKey.currentState;

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      observers: <NavigatorObserver>[widget.navigatorObserver],
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String name = settings.name!;

    if (name == '/') {
      return DesktopPageRoute<dynamic>(
        builder: widget.builder,
        settings: settings,
      );
    } else if (widget.menuRouteBuilder != null) {
      return widget.menuRouteBuilder!(context, settings);
    }

    return null;
  }

  Route<dynamic>? _onUnknownRoute(RouteSettings settings) {
    final name = settings.name!.replaceFirst(r'/', '');

    ThemeData themeData = Theme.invertedThemeOf(context);

    return NavMenuRoute(
      axis: NavigationScope.of(context)!.navAxis,
      pageBuilder: (context) => Container(
        alignment: Alignment.center,
        color: themeData.colorScheme.background3.toColor(),
        child: Text(
          'Page "$name" not found',
          style: themeData.textTheme.title,
        ),
      ),
      settings: settings,
    );
  }
}
