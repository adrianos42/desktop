import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'nav_scope.dart';

class NavDialog extends StatefulWidget {
  NavDialog({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  _NavDialogState createState() => _NavDialogState();
}

class _NavDialogState extends State<NavDialog> {
  @override
  Widget build(BuildContext context) {
    final navScope = NavigationScope.of(context)!;
    final axis = navScope.navAxis;

    print('Current axis: $axis');

    return Container(
      height: axis == Axis.horizontal ? 200.0 : null,
      width: axis == Axis.vertical ? 400.0 : null,
      color: Theme.of(context).colorScheme.background.toColor(), //// TODO Set this in theme.
      child: widget.child,
    );
  }
}
