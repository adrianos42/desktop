import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'tab_scope.dart';

class TabDialog extends StatefulWidget {
  const TabDialog({
    required this.child,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final Widget child;

  /// The height of the dialog in case the nav axis is horizontal.
  final double? height;

  /// The width of the dialog in case the nav axis is vertical.
  final double? width;

  @override
  _TabDialogState createState() => _TabDialogState();
}

class _TabDialogState extends State<TabDialog> {
  @override
  Widget build(BuildContext context) {
    final navScope = TabScope.of(context)!;
    final axis = navScope.axis;

    return Container(
      height: axis == Axis.horizontal
          ? widget.height
          : null, // TODO(as): Set this in theme.
      width: axis == Axis.vertical
          ? widget.width
          : null, // TODO(as): Set this in theme.
      color: Theme.of(context)
          .colorScheme
          .background[0], // TODO(as): Set this in theme.
      child: widget.child,
    );
  }
}
