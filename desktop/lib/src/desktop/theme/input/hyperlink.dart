import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'hyperlink.g.dart';

const double _kLineThickness = 1.0;

/// Theme data for [HyperlinkButton].
@immutable
class _HyperlinkThemeData {
  const _HyperlinkThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The color of the hyperlink text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// PrimaryColors.dodgerBlue.primaryColor
  /// .withBrightness(colorScheme.brightness)
  /// .color
  /// ```
  Color get color => PrimaryColors.dodgerBlue.primaryColor
      .withBrightness(colorScheme.brightness)
      .color;

  /// The color of the hyperlink text when hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => textTheme.textHigh;

  /// The text style of the hyperlink.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(
  ///   fontSize: 14.0,
  ///   decoration: TextDecoration.underline,
  ///   decorationThickness: 1.0,
  ///   overflow: TextOverflow.ellipsis,
  /// )
  /// ```
  TextStyle get textStyle => textTheme.body2.copyWith(
        fontSize: 14.0,
        decoration: TextDecoration.underline,
        decorationThickness: _kLineThickness,
        overflow: TextOverflow.ellipsis,
      );

  /// The color of the hyperlink text when highlighted.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get highlightColor => textTheme.textLow;
}
