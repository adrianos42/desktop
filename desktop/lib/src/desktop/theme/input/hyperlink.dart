import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'hyperlink.g.dart';

const double _kLineThickness = 1.0;

/// Theme data for [HyperlinkButton].
@immutable
class _HyperlinkThemeData {
  const _HyperlinkThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.contentTextTheme;

  bool get _isDark => _themeData.brightness == Brightness.dark;

  /// The color of the hyperlink text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// PrimaryColors.dodgerBlue.primaryColor
  /// .withBrightness(colorScheme.brightness)
  /// .color
  /// ```
  Color get color => PrimaryColors.dodgerBlue.primaryColor.color;

  /// The color of the hyperlink text when hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => _isDark ? _textTheme.textHigh : _textTheme.textLow;

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
  TextStyle get textStyle => _textTheme.body2.copyWith(
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
  Color get highlightColor =>
      _isDark ? _textTheme.textLow : _textTheme.textHigh;
}
