import 'package:desktop/src/theme_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'theme_hyperlink_button.dart';

class HyperlinkButton extends StatelessWidget {
  const HyperlinkButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.tooltip,
  })  : assert(text != null),
        super(key: key);

  final String text;

  final String tooltip;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);
    final HyperlinkButtonThemeData hyperlinkButtonThemeData =
        HyperlinkButtonTheme.of(context);

    return ButtonTheme.merge(
      data: buttonThemeData.copyWith(
        textStyle: hyperlinkButtonThemeData.textStyle,
        color: hyperlinkButtonThemeData.color,
      ),
      child: Button(
        body: Text(text),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
