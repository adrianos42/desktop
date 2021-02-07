import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class IconButton extends StatelessWidget {
  const IconButton(this.icon, {
    Key? key,
    this.tooltip,
    required this.onPressed,
  })  : super(key: key);

  final String? tooltip;

  final IconData icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      tooltip: tooltip,
      body: Icon(icon),
    );
  }
}
