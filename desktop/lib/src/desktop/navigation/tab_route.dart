import 'package:flutter/widgets.dart';

import '../localizations.dart';

class TabMenuRoute<T> extends PopupRoute<T> {
  TabMenuRoute({
    required WidgetBuilder pageBuilder,
    required BuildContext context,
    String? barrierLabel,
    RouteSettings? settings,
    required HSLColor barrierColor,
    this.axis = Axis.horizontal,
  })   : _pageBuilder = pageBuilder,
        _barrierLabel = barrierLabel ?? DesktopLocalizations.of(context).modalBarrierDismissLabel,
        _barrierColor = barrierColor.toColor(),
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
  Color? get barrierColor => _barrierColor;
  final Color _barrierColor;

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