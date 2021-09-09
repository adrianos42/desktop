import 'dart:ui';
import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';
import 'data/data.dart';
import 'navigation/navigation.dart';
import 'dialogs/dialogs.dart';
import 'input/input.dart';
import 'status/status.dart';
import 'text/text.dart';
import 'scrolling.dart';
import 'typography.dart';
import 'colorscheme.dart';
import 'overview.dart';
import 'routes/delegate.dart';

void main() => runApp(
      DesktopApp.router(
        routeInformationParser: const DocsInformationParser(),
        routerDelegate: DocsRouteDelegate(),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
