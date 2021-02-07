import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'route.dart';

class DesktopApp extends StatefulWidget {
  const DesktopApp({
    Key? key,
    required this.home,
    this.theme,
    this.title = '',
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.debugShowCheckedModeBanner = false,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.locale,
    this.localeResolutionCallback,
    this.localeListResolutionCallback,
    this.localizationsDelegates,
    this.onGenerateTitle,
    this.builder,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onUnknownRoute,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.shortcuts,
    // this.actions,
    this.onGenerateRoute,
  })  :super(key: key);

  // static final Map<LogicalKeySet, Intent> _shortcuts = <LogicalKeySet, Intent>{
  //   // LogicalKeySet(LogicalKeyboardKey.escape): Intent(DismissModalAction.key),
  //   // LogicalKeySet(LogicalKeyboardKey.escape): Intent(NavItemCloseAction.key),
  //   // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.tab):
  //   //     Intent(NextNavViewAction.key),
  //   // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
  //   //     LogicalKeyboardKey.tab): Intent(PreviousNavViewAction.key),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit1):
  //       SetViewIntent(0),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit2):
  //       SetViewIntent(1),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit3):
  //       SetViewIntent(2),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit4):
  //       SetViewIntent(3),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit5):
  //       SetViewIntent(4),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit6):
  //       SetViewIntent(5),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit7):
  //       SetViewIntent(6),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit8):
  //       SetViewIntent(7),
  //   LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit9):
  //       SetViewIntent(8),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit1):
  //       SetTabIntent(0),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit2):
  //       SetTabIntent(1),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit3):
  //       SetTabIntent(2),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit4):
  //       SetTabIntent(3),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit5):
  //       SetTabIntent(4),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit6):
  //       SetTabIntent(5),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit7):
  //       SetTabIntent(6),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit8):
  //       SetTabIntent(7),
  //   LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit9):
  //       SetTabIntent(8),
  // };

  // static final Map<LocalKey, ActionFactory> _actions =
  //     <LocalKey, ActionFactory>{
  //   SetTabAction.key: () => const SetTabAction(),
  //   DismissModalAction.key: () => DismissModalAction(),
  //   NavItemCloseAction.key: () => const NavItemCloseAction(),
  //   NextNavViewAction.key: () => const NextNavViewAction(),
  //   PreviousNavViewAction.key: () => const PreviousNavViewAction(),
  //   SetViewAction.key: () => const SetViewAction(),
  //   ShowNavMenuAction.key: () => const ShowNavMenuAction(),
  // };

  final GlobalKey<NavigatorState>? navigatorKey;

  final Map<String, WidgetBuilder> routes;

  final String? initialRoute;

  final RouteFactory? onGenerateRoute;

  final RouteFactory? onUnknownRoute;

  final List<NavigatorObserver> navigatorObservers;

  final TransitionBuilder? builder;

  final GenerateAppTitle? onGenerateTitle;

  final Locale? locale;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final LocaleListResolutionCallback? localeListResolutionCallback;

  final LocaleResolutionCallback? localeResolutionCallback;

  final Iterable<Locale> supportedLocales;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information
  /// reported by the framework.
  final bool showSemanticsDebugger;

  final bool debugShowCheckedModeBanner;

  final Widget home;

  final ThemeData? theme;

  final String title;

  final bool showPerformanceOverlay;

  // final Map<LocalKey, ActionFactory> actions;

  final Map<LogicalKeySet, Intent>? shortcuts;

  @override
  _DesktopAppState createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(DesktopApp oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationDelegates sync* {
    if (widget.localizationsDelegates != null) {
      yield* widget.localizationsDelegates!; // FIXME
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData effectiveThemeData =
        widget.theme ?? ThemeData(brightness: Brightness.dark);

    return Theme(
      data: effectiveThemeData,
      child: Builder(builder: (BuildContext context) {
        final Widget result = ScrollConfiguration(
            behavior: _DesktopScrollBehavior(), child: widget.home);

        return WidgetsApp(
          key: GlobalObjectKey(this),
          navigatorKey: widget.navigatorKey,
          navigatorObservers: widget.navigatorObservers,
          pageRouteBuilder:
              <T>(RouteSettings settings, WidgetBuilder builder) =>
                  DesktopPageRoute<T>(settings: settings, builder: builder),
          routes: widget.routes,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
          builder: widget.builder,
          onGenerateTitle: widget.onGenerateTitle,
          locale: widget.locale,
          localizationsDelegates: _localizationDelegates,
          localeResolutionCallback: widget.localeResolutionCallback,
          localeListResolutionCallback: widget.localeListResolutionCallback,
          supportedLocales: widget.supportedLocales,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          showSemanticsDebugger: widget.showSemanticsDebugger,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          home: Container(
            color: effectiveThemeData.colorScheme.background,
            child: result,
          ),
          title: widget.title,
          color: effectiveThemeData.colorScheme.primary,
          // actions: <LocalKey, ActionFactory>{
          //   ...WidgetsApp.defaultActions,
          //   ...DesktopApp._actions,
          // },
          // shortcuts: <LogicalKeySet, Intent>{
          //   ...WidgetsApp.defaultShortcuts,
          //   ...DesktopApp._shortcuts,
          // },
          textStyle: null,
        );
      }),
    );
  }
}

class _DesktopScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _ClampingScrollPhysics();
  }
}

class _ClampingScrollPhysics extends ClampingScrollPhysics {
  const _ClampingScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return false;
  }

  @override
  _ClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ClampingScrollPhysics(parent: buildParent(ancestor));
  }
}
