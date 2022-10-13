import 'package:desktop/desktop.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'home.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'en_GB';
  initializeDateFormatting('en_GB').then((_) {
    runApp(
      const DesktopApp(
        home: DocApp(),
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: true,
      ),
    );
  });
}
