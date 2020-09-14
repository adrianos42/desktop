import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'theme_color.dart';
import 'theme_nav.dart';
import 'nav_scope.dart';

class SettingsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavThemeData navThemeData = NavTheme.of(context);
    final NavScope navScope = NavScope.of(context);
    final axis = navScope.navAxis;

    return Container(
      height: axis == Axis.horizontal ? 200.0 : null,
      width: axis == Axis.vertical ? 400.0 : null,
      child: Flex(
        direction: axis,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            //flex: 10,
            child: Container(
              color: navThemeData.background,
            ),
          ),
        ],
      ),
    );
  }
}
