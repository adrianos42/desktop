import 'package:flutter/widgets.dart';

import 'theme/theme.dart';
import 'navigation/nav_scope.dart';

class SettingsBar extends StatelessWidget {
  SettingsBar({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final NavThemeData navThemeData = NavTheme.of(context);
    //final NavigationScope navScope = NavigationScope.of(context)!;
    final axis = Axis.horizontal;

    return Container(
      height: axis == Axis.horizontal ? 200.0 : null,
      width: axis == Axis.vertical ? 400.0 : null,
      child: Flex(
        direction: axis,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
            Container(
              color: navThemeData.background,
              child: child,
            ),
        ],
      ),
    );
  }
}
