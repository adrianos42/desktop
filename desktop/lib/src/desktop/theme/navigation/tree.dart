import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'tree.g.dart';

/// Theme data for [Tree].
@immutable
class _TreeThemeData {
  const _TreeThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.contentTextTheme;
  ColorScheme get _colorScheme => _themeData.contentColorScheme;

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: defaultFontSize)
  /// ```
  TextStyle get textStyle =>
      _textTheme.body2.copyWith(fontSize: defaultFontSize);

  /// The color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get color => _textTheme.textLow;

  /// The hover color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => _textTheme.textHigh;

  /// The highlight color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get highlightColor => _colorScheme.primary[highlightColorIndex];

  /// The indicator highlight color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get indicatorHighlightColor =>
      _colorScheme.primary[highlightColorIndex];

  /// The indicator hover highlight color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get indicatorHoverColor => _textTheme.textHigh;

  /// The indicator color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  Color get indicatorColor => _colorScheme.background[20];
}
