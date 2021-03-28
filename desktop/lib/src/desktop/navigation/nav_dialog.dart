import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'nav_scope.dart';

class NavDialog extends StatefulWidget {
  NavDialog({
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
  _NavDialogState createState() => _NavDialogState();
}

class _NavDialogState extends State<NavDialog> {
  @override
  Widget build(BuildContext context) {
    final navScope = NavigationScope.of(context)!;
    final axis = navScope.navAxis;

    return Container(
      height: axis == Axis.horizontal
          ? widget.height
          : null, //// FIXME Set this in theme.
      width: axis == Axis.vertical
          ? widget.width
          : null, //// FIXME Set this in theme.
      color: Theme.of(context)
          .colorScheme
          .background
          .toColor(), //// FIXME Set this in theme.
      child: widget.child,
    );
  }
}
