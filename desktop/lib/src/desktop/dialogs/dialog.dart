import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../input/button.dart';
import '../theme/theme.dart';
import '../localizations.dart';

const Duration _kDialogDuration = Duration(milliseconds: 200);
const Curve _kDialogCurve = Curves.easeOut;

/// A [DialogRound] for dialogs.
class DialogRoute<T> extends PopupRoute<T> {
  /// Creates a [DialogRoute].
  DialogRoute({
    required RoutePageBuilder pageBuilder,
    required BuildContext context,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color? barrierColor,
    ImageFilter? filter,
    this.themes,
    super.settings,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel ??
            DesktopLocalizations.of(context).modalBarrierDismissLabel,
        _barrierColor = barrierColor ?? DialogTheme.of(context).barrierColor!,
        super(
          filter: filter ?? DialogTheme.of(context).imageFilter!,
        );

  final RoutePageBuilder _pageBuilder;

  final _curve = _kDialogCurve;

  ///
  final CapturedThemes? themes;

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
    final Widget pageChild = Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
      focused: true,
    );

    return themes?.wrap(pageChild) ?? pageChild;
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

class DialogAction {
  const DialogAction({
    required this.title,
    required this.onPressed,
  });

  final String title;

  final VoidCallback onPressed;
}

class Dialog extends StatelessWidget {
  /// Creates a [Dialog].
  const Dialog({
    super.key,
    this.title,
    this.actions,
    this.allowScroll = true,
    this.theme,
    required this.body,
  });

  /// The widget placed between the title and menus.
  final Widget body;

  /// The widget placed above the body.
  final Widget? title;

  /// Widgets to be placed at the bottom right of the dialog.
  final List<DialogAction>? actions;

  final bool allowScroll;

  /// The style [DialogThemeData] of the dialog.
  final DialogThemeData? theme;

  static Future<T?> showDialog<T>(
    BuildContext context, {
    required Widget body,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    List<DialogAction>? actions,
    DialogThemeData? theme,
    Widget? title,
    bool allowScroll = true,
  }) {
    final Color barrierColor = DialogTheme.of(context).barrierColor!;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).context,
    );

    return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
      DialogRoute<T>(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Dialog(
          body: body,
          actions: actions,
          theme: theme,
          title: title,
          allowScroll: allowScroll,
        ),
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        settings: routeSettings,
        themes: themes,
      ),
    );
  }

  static Future<T?> showCustomDialog<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    final Color barrierColor = DialogTheme.of(context).barrierColor!;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).context,
    );

    return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
      DialogRoute<T>(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        settings: routeSettings,
        themes: themes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    final DialogThemeData dialogThemeData =
        DialogTheme.of(context).merge(theme);

    final Color backgroundColor = dialogThemeData.background!;

    Widget result = Container(
      constraints: dialogThemeData.constraints,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: dialogThemeData.titlePadding!,
              child: DefaultTextStyle(
                child: title!,
                style: dialogThemeData.titleTextStyle!,
              ),
            ),
          if (allowScroll)
            Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  0.0,
                  dialogThemeData.bodyPadding!.top,
                  0.0,
                  dialogThemeData.bodyPadding!.bottom,
                ),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  padding: EdgeInsets.fromLTRB(
                    dialogThemeData.bodyPadding!.left,
                    0.0,
                    dialogThemeData.bodyPadding!.right,
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
          if (!allowScroll)
            Padding(
              padding: dialogThemeData.bodyPadding!,
              child: DefaultTextStyle(
                child: body,
                textAlign: dialogThemeData.bodyTextAlign!,
                style: textTheme.body1,
              ),
            ),
          if (actions != null)
            Container(
              alignment: Alignment.centerRight,
              padding: dialogThemeData.menuPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: actions!
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Button.text(
                          e.title,
                          onPressed: e.onPressed,
                        ),
                      ),
                    )
                    .toList(),
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
