import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../localizations.dart';
import '../theme/dialogs/dialog.dart';

const Duration _kDialogDuration = Duration(milliseconds: 300);

class NextTabIntent extends Intent {
  /// Creates an intent that is used with [NextTabIntent].
  const NextTabIntent();
}

class PreviousTabIntent extends Intent {
  /// Creates an intent that is used with [PreviousTabIntent].
  const PreviousTabIntent();
}

mixin _DesktopRouteTransitionMixin<T> on PageRoute<T> {
  @protected
  Widget buildContent(BuildContext context);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return nextRoute is _DesktopRouteTransitionMixin &&
        !nextRoute.fullscreenDialog;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = buildContent(context);
    assert(() {
      if (result == null) {
        throw FlutterError(
          'The builder for route "${settings.name}" returned null.\n'
          'Route builders must never return null.',
        );
      }
      return true;
    }());
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
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
    return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child);
  }
}

class DesktopPageRoute<T> extends PageRoute<T>
    with _DesktopRouteTransitionMixin {
  DesktopPageRoute({
    required this.builder,
    RouteSettings? settings,
    bool fullscreenDialog = true,
    this.maintainState = true,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}

class DesktopPage<T> extends Page<T> {
  const DesktopPage({
    required this.child,
    this.maintainState = true,
    this.fullscreenDialog = false,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  final Widget child;

  final bool maintainState;

  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedDesktopPageRoute<T>(page: this);
  }
}

class _PageBasedDesktopPageRoute<T> extends PageRoute<T>
    with _DesktopRouteTransitionMixin<T> {
  _PageBasedDesktopPageRoute({required DesktopPage<T> page})
      : super(settings: page);

  DesktopPage<T> get _page => settings as DesktopPage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLevel => '${super.debugLabel}(${_page.name})';
}

abstract class ContextRoute<T> extends ModalRoute<T> {
  ContextRoute({
    required RouteSettings settings,
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
    required RoutePageBuilder pageBuilder,
    required BuildContext context,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
    ImageFilter? filter,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel ??
            DesktopLocalizations.of(context).modalBarrierDismissLabel,
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
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder? _transitionBuilder;

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
    return _transitionBuilder!(
        context, animation, secondaryAnimation, child); // TODO(as): ???
  }
}

Future<T?> showDesktopPopup<T>({
  required BuildContext context,
  required RoutePageBuilder pageBuilder,
  bool barrierDismissible = true,
  String? barrierLabel,
}) {
  return Navigator.of(context, rootNavigator: false).push<T>(
    _DialogRoute<T>(
      context: context,
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
