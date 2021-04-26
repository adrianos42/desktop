import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

import 'button.dart';

typedef FunctionStringCallback = void Function(String);

class HyperlinkButton extends StatelessWidget {
  const HyperlinkButton(
    this.text, {
    Key? key,
    this.onPressed,
    this.tooltip,
  }) : super(key: key);

  final String text;

  final String? tooltip;

  final FunctionStringCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);
    final HyperlinkButtonThemeData hyperlinkButtonThemeData =
        HyperlinkButtonTheme.of(context);

    return ButtonTheme.merge(
      data: buttonThemeData.copyWith(
        textStyle: hyperlinkButtonThemeData.textStyle,
        color: hyperlinkButtonThemeData.color,
        hoverColor: hyperlinkButtonThemeData.hoverColor,
        highlightColor: hyperlinkButtonThemeData.highlightColor,
      ),
      child: Button(
        body: Text(text),
        tooltip: tooltip,
        onPressed: onPressed != null ? () => onPressed!(text) : null,
      ),
    );
  }
}
