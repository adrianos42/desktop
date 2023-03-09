import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'button.dart';

/// Callback that with [String] parameter.
typedef FunctionStringCallback = void Function(String);

/// A button with a default 'hyperlink' style.
class HyperlinkButton extends StatelessWidget {
  ///
  const HyperlinkButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.padding,
    this.tooltip,
    this.theme,
  });

  /// The text for the button.
  final String text;

  /// The button tooltip.
  final String? tooltip;

  /// The button padding.
  final EdgeInsets? padding;

  /// The style [HyperlinkThemeData] of the button.
  final HyperlinkThemeData? theme;

  /// Called when button is pressed, with the text as an argument.
  /// This helps in the case the full url was used,
  /// and then use the url text when the hyperlink is pressed.
  final FunctionStringCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);
    final HyperlinkThemeData hyperlinkButtonThemeData =
        HyperlinkTheme.of(context).merge(theme);

    return ButtonTheme.merge(
      data: buttonThemeData.copyWith(
        textStyle: hyperlinkButtonThemeData.textStyle,
        color: hyperlinkButtonThemeData.color,
        hoverColor: hyperlinkButtonThemeData.hoverColor,
        highlightColor: hyperlinkButtonThemeData.highlightColor,
      ),
      child: Builder(
        builder: (context) => Button(
          body: Text(text),
          tooltip: tooltip,
          padding: padding,
          bodyPadding: padding != null ? EdgeInsets.zero : null,
          onPressed: onPressed != null ? () => onPressed!(text) : null,
        ),
      ),
    );
  }
}
