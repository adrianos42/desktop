import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class TextButton extends StatelessWidget {
  const TextButton(this.text, {
    Key key,
    @required this.onPressed,
    this.color,
    this.tooltip,
  })  : assert(text != null),
        super(key: key);

  final String text;

  final String tooltip;

  final Color color;

  final VoidCallback onPressed;

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
