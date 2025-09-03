import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../localizations.dart';
import '../theme/theme.dart';

const Duration _kDuration = Duration(milliseconds: 400);
const Duration _kReverseDuration = Duration(milliseconds: 400);
const Curve _kCurve = Curves.fastEaseInToSlowEaseOut;

/// A [DrawerRound] for drawers.
class DrawerRoute<T> extends PopupRoute<T> {
  /// Creates a [DrawerRoute].
  DrawerRoute({
    required WidgetBuilder pageBuilder,
    required BuildContext context,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color? barrierColor,
    ImageFilter? filter,
    this.themes,
    super.settings,
  }) : _pageBuilder = pageBuilder,
       _barrierDismissible = barrierDismissible,
       _barrierLabel =
           barrierLabel ??
           DesktopLocalizations.of(context).modalBarrierDismissLabel,
       _barrierColor = barrierColor ?? DrawerTheme.of(context).barrierColor!,
       super(filter: filter ?? DrawerTheme.of(context).imageFilter!);

  final WidgetBuilder _pageBuilder;

  final _curve = _kCurve;

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
  Duration get transitionDuration => _kDuration;

  @override
  Duration get reverseTransitionDuration => _kReverseDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget pageChild = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      focused: true,
      child: _pageBuilder(context),
    );

    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position:
            Tween(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: _curve,
                reverseCurve: _curve.flipped,
              ),
            ),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: _curve,
            reverseCurve: _curve.flipped,
          ),
          child: themes?.wrap(pageChild) ?? pageChild,
        ),
      ),
    );
  }
}

class Drawer extends StatelessWidget {
  /// Creates a [Drawer].
  const Drawer({super.key, this.title, this.actions, required this.body});

  /// The widget placed between the title and menus.
  final Widget body;

  /// The widget placed above the body.
  final Widget? title;

  /// Widgets to be placed at the bottom right of the drawer.
  final List<Widget>? actions;

  static Future<T?> showDrawer<T>(
    BuildContext context, {
    required Widget body,
    Color? barrierColor,
    String? barrierLabel,
    RouteSettings? routeSettings,
    List<Widget>? actions,
    Widget? title,
  }) {
    final Color barrierColor = DrawerTheme.of(context).barrierColor!;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(context, rootNavigator: true).context,
    );

    return Navigator.of(context, rootNavigator: true).push<T>(
      DrawerRoute<T>(
        context: context,
        pageBuilder: (context) =>
            Drawer(body: body, actions: actions, title: title),
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        settings: routeSettings,
        themes: themes,
      ),
    );
  }

  static Future<T?> showCustomDrawer<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    RouteSettings? routeSettings,
  }) {
    final Color barrierColor = DrawerTheme.of(context).barrierColor!;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(context, rootNavigator: true).context,
    );

    return Navigator.of(context, rootNavigator: true).push<T>(
      DrawerRoute<T>(
        context: context,
        pageBuilder: (context) => builder(context),
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

    final DrawerThemeData drawerThemeData = DrawerTheme.of(context);

    final Color backgroundColor = drawerThemeData.background!;

    final Widget child = Padding(
      padding: drawerThemeData.bodyPadding!,
      child: DefaultTextStyle(
        textAlign: drawerThemeData.bodyTextAlign!,
        style: textTheme.body1,
        child: body,
      ),
    );

    final Widget result = Container(
      constraints: drawerThemeData.constraints,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: drawerThemeData.titlePadding!,
              child: DefaultTextStyle(
                style: drawerThemeData.titleTextStyle!,
                child: title!,
              ),
            ),
          Expanded(child: child),
          if (actions != null)
            Padding(
              padding: drawerThemeData.menuPadding!,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  actions!.length,
                  (index) => Padding(
                    padding: index > 0
                        ? EdgeInsets.only(left: drawerThemeData.menuSpacing!)
                        : EdgeInsets.zero,
                    child: ButtonTheme.copyWith(
                      itemSpacing: 0.0,
                      child: actions![index],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return Focus(autofocus: true, debugLabel: 'Drawer', child: result);
  }
}
