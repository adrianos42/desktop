import 'theme_button.dart';
import 'theme_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart' show Curves;

import 'theme.dart';
import 'theme_text.dart';

class Dialog extends StatelessWidget {
  const Dialog({
    Key? key,
    this.title,
    this.menus,
    this.constraints,
    this.padding,
    this.dialogPadding,
    required this.body,
  }) : super(key: key);

  final Widget body;

  final Widget? title;

  final List<Widget>? menus;

  final BoxConstraints? constraints;

  final EdgeInsets? padding;

  final EdgeInsets? dialogPadding;

  static void close(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    final DialogThemeData dialogThemeData = DialogTheme.of(context);

    final Color backgroundColor = dialogThemeData.background!;

    Widget result = Container(
      constraints: constraints ?? dialogThemeData.constraints,
      padding: dialogPadding ?? dialogThemeData.dialogPadding,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: dialogThemeData.titlePadding,
                  child: DefaultTextStyle(
                    child: title!, // FIXME
                    textAlign: TextAlign.start,
                    style: textTheme.title,
                  ),
                ),
              DefaultTextStyle(
                child: body,
                textAlign: TextAlign.justify,
                style: themeData.textTheme.body1.copyWith(
                  color: textTheme.textMedium,
                ),
              ),
            ],
          ),
          if (menus != null)
            ButtonTheme.merge(
              data: ButtonThemeData(
                bodyPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.only(left: 16.0),
              ),
              child: Padding(
                padding: dialogThemeData.menuPadding,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    //color: Theme.of(context).colorScheme.overlay6,
                    constraints: BoxConstraints(
                      maxHeight: 38.0,
                      minHeight: 38.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: menus!, // FIXME
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    result = Padding(
      padding: padding ?? dialogThemeData.outsidePadding,
      child: result,
    );

    return Focus(
      child: Center(child: result),
      autofocus: true,
      debugLabel: 'Dialog',
    );
  }
}

class DialogRoute<T> extends PopupRoute<T> {
  DialogRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String? barrierLabel,
    RouteSettings? settings,
    Color? barrierColor,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

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
  Duration get transitionDuration => const Duration(milliseconds: 200);

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
        curve: Curves.linear,
      ),
      child: child,
    );
  }
}

Future<T?> showDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(createDialogRoute(
    builder: builder,
    context: context,
    barrierDismissible: barrierDismissible,
  ));
}

PopupRoute<T> createDialogRoute<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  final DialogThemeData dialogThemeData = DialogTheme.of(context);
  final Color? barrierColor = dialogThemeData.barrierColor;

  return DialogRoute<T>(
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      pageBuilder: (context, _, __) => builder(context));
}
