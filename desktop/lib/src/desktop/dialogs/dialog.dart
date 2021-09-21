import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart' show Curves;

import '../localizations.dart';
import '../theme/theme.dart';

const Duration _kDialogDuration = Duration(milliseconds: 300);

class Dialog extends StatelessWidget {
  /// Creates a [Dialog].
  const Dialog({
    Key? key,
    this.title,
    this.menus,
    this.constraints,
    //this.padding,
    //this.dialogPadding,
    required this.body,
  }) : super(key: key);

  /// The widget placed between the title and menus.
  final Widget body;

  /// The widget placed above the body.
  final Widget? title;

  /// Widgets to be placed at the bottom right of the dialog.
  final List<Widget>? menus;

  /// The constraints for the dialog.
  final BoxConstraints? constraints;

  // final EdgeInsets? padding;

  //final EdgeInsets? dialogPadding;

  // Closes the dialog.
  static void close(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    final DialogThemeData dialogThemeData = DialogTheme.of(context);

    final Color backgroundColor = dialogThemeData.background!.toColor();

    Widget result = Container(
      constraints: constraints ?? dialogThemeData.constraints,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: dialogThemeData.titlePadding,
              child: DefaultTextStyle(
                child: title!, // TODO(as): ???
                style: dialogThemeData.titleTextStyle!,
              ),
            ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0.0,
                dialogThemeData.bodyPadding.top,
                0.0,
                dialogThemeData.bodyPadding.bottom,
              ),
              child: SingleChildScrollView(
                controller: ScrollController(),
                padding: EdgeInsets.fromLTRB(
                  dialogThemeData.bodyPadding.left,
                  0.0,
                  dialogThemeData.bodyPadding.right,
                  0.0,
                ),
                child: DefaultTextStyle(
                  child: body,
                  textAlign: dialogThemeData.bodyTextAlign!,
                  style: textTheme.body1,
                ),
              ),
            ),
          ),
          if (menus != null)
            Container(
              alignment: Alignment.centerRight,
              padding: dialogThemeData.menuPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: menus!, // TODO(as): ???
              ),
            ),
        ],
      ),
    );

    result = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 2),
        Flexible(child: result, flex: 8),
        const Spacer(flex: 2),
      ],
    );

    return Focus(
      child: Center(child: result),
      autofocus: true,
      debugLabel: 'Dialog',
    );
  }
}

class DialogRoute<T> extends PopupRoute<T> {
  /// Creates a [DialogRoute].
  DialogRoute({
    required RoutePageBuilder pageBuilder,
    required BuildContext context,
    bool barrierDismissible = true,
    String? barrierLabel,
    RouteSettings? settings,
    Color? barrierColor,
    ImageFilter? filter,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel ??
            DesktopLocalizations.of(context).modalBarrierDismissLabel,
        _barrierColor =
            barrierColor ?? DialogTheme.of(context).barrierColor!.toColor(),
        super(settings: settings, filter: filter);

  final RoutePageBuilder _pageBuilder;

  final _curve = Curves.easeOut;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color? get barrierColor => _barrierColor;
  final Color? _barrierColor;

  @override
  Duration get transitionDuration => _kDialogDuration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
      focused: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: _curve,
        reverseCurve: _curve.flipped,
      ),
      child: child,
    );
  }
}

/// Shows a dialog with default [DialogRoute].
Future<T?> showDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  ImageFilter? filter,
  HSLColor? barrierColor,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(DialogRoute<T>(
    pageBuilder: (context, _, __) => builder(context),
    context: context,
    barrierDismissible: barrierDismissible,
    filter: filter,
    barrierColor: barrierColor?.toColor(),
  ));
}
