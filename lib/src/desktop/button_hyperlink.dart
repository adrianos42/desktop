import 'theme_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'theme_hyperlink_button.dart';

class HyperlinkButton extends StatelessWidget {
  const HyperlinkButton(this.text, {
    Key? key,
    this.onPressed,
    this.tooltip,
  })  : 
        super(key: key);

  final String text;

  final String? tooltip;

  final VoidCallback? onPressed;

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
