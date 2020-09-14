import 'dart:async';
import 'dart:math';
import 'dart:ui' show lerpDouble, ImageFilter;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart' show Curves;

class DesktopPageRoute<T> extends PageRoute<T> {
  DesktopPageRoute({
    @required this.builder,
    this.title,
    RouteSettings settings,
    bool fullscreenDialog = true,
    this.maintainState = true,
  })  : assert(builder != null),
        assert(fullscreenDialog != null),
        assert(maintainState != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  final String title;

  ValueNotifier<String> _previousTitle;

  ValueListenable<String> get previousTitle {
    assert(_previousTitle != null);

    return _previousTitle;
  }

  @override
  void didChangePrevious(Route<dynamic> previousRoute) {
    final String previousTitleString =
        previousRoute is DesktopPageRoute ? previousRoute.title : null;

    if (_previousTitle == null) {
      _previousTitle = ValueNotifier<String>(previousTitleString);
    } else {
      _previousTitle.value = previousTitleString;
    }

    super.didChangePrevious(previousRoute);
  }

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool canTransionTo(TransitionRoute<dynamic> nextRoute) {
    return nextRoute is DesktopPageRoute && !nextRoute.fullscreenDialog;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget child = builder(context);

    Widget result = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: child,
    );

    return result;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {


    return buildPageTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }

  static Widget buildPageTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
    // return FadeTransition(
    //       opacity: CurvedAnimation(
    //         parent: animation,
    //         curve: Curves.easeOut,
    //       ),
    //       child: child);
  }
}



abstract class ContextRoute<T> extends ModalRoute<T> {
  ContextRoute({
    RouteSettings settings,
  }) : super(
          filter: null,
          settings: settings,
        );

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;
}

class _DialogRoute<T> extends PopupRoute<T> {
  _DialogRoute({
    @required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder transitionBuilder,
    RouteSettings settings,
    ImageFilter filter,
  })  : assert(barrierDismissible != null),
        _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
        super(
          settings: settings,
          filter: filter,
        );

  final RoutePageBuilder _pageBuilder;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}

Future<T> showDesktopPopup<T>({
  @required BuildContext context,
  @required RoutePageBuilder pageBuilder,
  bool barrierDismissible = true,
  String barrierLabel,
}) {
  assert(context != null);
  assert(pageBuilder != null);

  return Navigator.of(context, rootNavigator: false).push<T>(
    _DialogRoute<T>(
      pageBuilder: pageBuilder,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
    ),
  );
}

// class DismissModalAction extends Action {
//   const DismissModalAction() : super(key);

//   static const LocalKey key = ValueKey<Type>(DismissModalAction);

//   @override
//   void invoke(FocusNode node, Intent intent) {
//     assert(ModalRoute.of(node.context) != null);
    
//     if (ModalRoute.of(node.context).barrierDismissible) {
//       assert(Navigator.of(node.context).canPop());
//       Navigator.of(node.context).pop();
//     }
//   }
// }
