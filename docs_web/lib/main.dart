import 'package:desktop/desktop.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'home.dart';

void main() {
  Intl.defaultLocale = 'en_GB';
  initializeDateFormatting('en_GB').then((_) {
    runApp(
      const DesktopApp(
        home: DocApp(),
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
      ),
    );
  });
}
