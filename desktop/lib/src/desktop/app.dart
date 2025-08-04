import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dialogs/message.dart';
import 'localizations.dart';
import 'navigation/route.dart';
import 'scrolling/scrolling.dart';
import 'theme/theme.dart';

/// Base functionality for desktop apps.
class DesktopApp extends StatefulWidget {
  /// Creates a [DesktopApp].
  ///
  /// At least one of [home], [routes], [onGenerateRoute], or [builder] must be
  /// non-null. If only [routes] is given, it must include an entry for the
  /// [Navigator.defaultRouteName] (`/`), since that is the route used when the
  /// application is launched with an intent that specifies an otherwise
  /// unsupported route.
  ///
  /// This class creates an instance of [WidgetApp].
  const DesktopApp({
    super.key,
    this.navigatorKey,
    this.home,
    this.theme,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.localeListResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.scrollBehavior,
    this.restorationScopeId,
    this.onNavigationNotification,
    this.debugShowWidgetInspector = false,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
  })  : routeInformationParser = null,
        routeInformationProvider = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null;

  /// Creates a [DesktopApp] that uses the [Router] instead of a [Navigator].
  const DesktopApp.router({
    super.key,
    required RouteInformationParser<Object> this.routeInformationParser,
    required RouterDelegate<Object> this.routerDelegate,
    this.routeInformationProvider,
    this.backButtonDispatcher,
    this.theme,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.routerConfig,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.scrollBehavior,
    this.restorationScopeId,
    this.debugShowWidgetInspector = false,
    this.onNavigationNotification,
  })  : navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null;

  static final _shortcuts = {
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.tab):
        const NextTabIntent(),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
        LogicalKeyboardKey.tab): const PreviousTabIntent(),
  };

  /// {@macro flutter.widgets.widgetsApp.navigatorKey}
  final GlobalKey<NavigatorState>? navigatorKey;

  /// {@macro flutter.widgets.widgetsApp.home}
  final Widget? home;

  /// The [DesktopTheme] style.
  final ThemeData? theme;

  /// The application's top-level routing table.
  ///
  /// When a named route is pushed with [Navigator.pushNamed], the route name is
  /// looked up in this map. If the name is present, the associated
  /// [WidgetBuilder] is used to construct a [DesktopPageRoute] that performs
  /// an appropriate transition, including [Hero] animations, to the new route.
  ///
  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder>? routes;

  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String? initialRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateInitialRoutes}
  final RouteFactory? onGenerateRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateInitialRoutes}
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory? onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver>? navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.routeInformationProvider}
  final RouteInformationProvider? routeInformationProvider;

  /// {@macro flutter.widgets.widgetsApp.routeInformationParser}
  final RouteInformationParser<Object>? routeInformationParser;

  /// {@macro flutter.widgets.widgetsApp.routerDelegate}
  final RouterDelegate<Object>? routerDelegate;

  /// {@macro flutter.widgets.widgetsApp.backButtonDispatcher}
  final BackButtonDispatcher? backButtonDispatcher;

  /// {@macro flutter.widgets.widgetsApp.builder}
  final TransitionBuilder? builder;

  /// {@macro flutter.widgets.widgetsApp.title}
  final String title;

  /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
  final GenerateAppTitle? onGenerateTitle;

  /// {@macro flutter.widgets.widgetsApp.color}
  final Color? color;

  /// {@macro flutter.widgets.widgetsApp.locale}
  final Locale? locale;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// {@macro flutter.widgets.LocaleResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  ///
  /// It is passed along unmodified to the [WidgetsApp] built by this widget.
  final Iterable<Locale> supportedLocales;

  /// Turns on a performance overlay.
  ///
  /// See also:
  ///
  ///  * <https://flutter.dev/debugging/#performanceoverlay>
  final bool showPerformanceOverlay;

  /// Turns on an overlay that enables inspecting the widget tree.
  ///
  /// The inspector is only available in debug mode as it depends on
  /// [RenderObject.debugDescribeChildren] which should not be called outside of
  /// debug mode.
  final bool debugShowWidgetInspector;

  /// {@template flutter.widgets.widgetsApp.onNavigationNotification}
  /// The callback to use when receiving a [NavigationNotification].
  ///
  /// By default this updates the engine with the navigation status and stops
  /// bubbling the notification.
  ///
  /// See also:
  ///
  ///  * [NotificationListener.onNotification], which uses this callback.
  /// {@endtemplate}
  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

  /// {@template flutter.widgets.widgetsApp.routerConfig}
  /// An object to configure the underlying [Router].
  ///
  /// If the [routerConfig] is provided, the other router related delegates,
  /// [routeInformationParser], [routeInformationProvider], [routerDelegate],
  /// and [backButtonDispatcher], must all be null.
  ///
  /// See also:
  ///
  ///  * [Router.withConfig], which receives this object when this
  ///    widget builds the [Router].
  /// {@endtemplate}
  final RouterConfig<Object>? routerConfig;

  /// Turns on an overlay that shows the accessibility information
  /// reported by the framework.
  final bool showSemanticsDebugger;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  /// Turned off by default.
  final bool debugShowCheckedModeBanner;

  /// {@macro flutter.widgets.widgetsApp.shortcuts}
  final Map<LogicalKeySet, Intent>? shortcuts;

  /// {@macro flutter.widgets.widgetsApp.actions}
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.widgetsApp.restorationScopeId}
  final String? restorationScopeId;

  /// When null, defaults to [DesktopScrollBehavior].
  final ScrollBehavior? scrollBehavior;

  @override
  State<DesktopApp> createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

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
      yield* widget.localizationsDelegates!;
    }

    yield DefaultDesktopLocalizations.delegate;
  }

  Widget _builder(BuildContext context, Widget? child) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Overlay(
          key: _overlayKey,
          initialEntries: [
            OverlayEntry(
              maintainState: true,
              opaque: true,
              builder: (context) => Messenger(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.background[0],
                  child: widget.builder != null
                      ? widget.builder!(context, child)
                      : child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  WidgetsApp _buildWidgetApp(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Color color = widget.color ?? themeData.colorScheme.primary[50];

    final shortcuts = {
      ...WidgetsApp.defaultShortcuts,
      ...DesktopApp._shortcuts,
      ...widget.shortcuts ?? {},
    };

    if (widget.routerDelegate != null) {
      return WidgetsApp.router(
        key: GlobalObjectKey(this),
        routeInformationParser: widget.routeInformationParser!,
        routerDelegate: widget.routerDelegate!,
        routeInformationProvider: widget.routeInformationProvider,
        backButtonDispatcher: widget.backButtonDispatcher,
        builder: _builder,
        title: widget.title,
        onGenerateTitle: widget.onGenerateTitle,
        textStyle: themeData.textTheme.body1,
        color: color,
        locale: widget.locale,
        localizationsDelegates: _localizationDelegates,
        localeResolutionCallback: widget.localeResolutionCallback,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        supportedLocales: widget.supportedLocales,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        debugShowWidgetInspector: widget.debugShowWidgetInspector,
        onNavigationNotification: widget.onNavigationNotification,
        routerConfig: widget.routerConfig,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
      );
    }

    return WidgetsApp(
      key: GlobalObjectKey(this),
      navigatorKey: widget.navigatorKey,
      navigatorObservers: widget.navigatorObservers!,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          DesktopPageRoute<T>(settings: settings, builder: builder),
      home: widget.home,
      routes: widget.routes!,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
      onUnknownRoute: widget.onUnknownRoute,
      builder: _builder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      textStyle: themeData.textTheme.body1,
      color: color,
      locale: widget.locale,
      localizationsDelegates: _localizationDelegates,
      localeResolutionCallback: widget.localeResolutionCallback,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      supportedLocales: widget.supportedLocales,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      debugShowWidgetInspector: widget.debugShowWidgetInspector,
      onNavigationNotification: widget.onNavigationNotification,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData effectiveThemeData = widget.theme ?? ThemeData();

    return Theme(
      data: effectiveThemeData,
      child: ScrollConfiguration(
        behavior: widget.scrollBehavior ?? const DesktopScrollBehavior(),
        child: IconTheme(
          data: IconThemeData(
            color: effectiveThemeData.textTheme.textHigh,
            fill: 1.0,
          ),
          child: Builder(builder: _buildWidgetApp),
        ),
      ),
    );
  }
}

/// Default [ScrollBehavior] for desktop.
class DesktopScrollBehavior extends ScrollBehavior {
  /// Creates a [DesktopScrollBehavior].
  const DesktopScrollBehavior({this.isAlwaysShown = true}) : super();

  /// See [Scrollbar].
  final bool isAlwaysShown;

  /// Applies a [Scrollbar] to the child widget.
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Scrollbar(
          isAlwaysShown: isAlwaysShown,
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}
