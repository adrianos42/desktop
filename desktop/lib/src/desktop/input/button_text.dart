import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class TextButton extends StatelessWidget {
  const TextButton(
    this.text, {
    Key? key,
    this.onPressed,
    this.color,
    this.tooltip,
  }) : super(key: key);

  final String text;

  final String? tooltip;

  final HSLColor? color;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      body: Text(text),
      tooltip: tooltip,
      onPressed: onPressed,
      color: color,
    );
  }
}
