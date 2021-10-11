import 'package:desktop/desktop.dart';
import 'routes/delegate.dart';

void main() {
  runApp(
    DesktopApp.router(
      routeInformationParser: const DocsInformationParser(),
      routerDelegate: DocsRouteDelegate(),
      backButtonDispatcher: RootBackButtonDispatcher(),
    ),
  );
}
