import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'tree.g.dart';

/// Theme data for [Tree].
@immutable
class _TreeThemeData {
  const _TreeThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: defaultFontSize)
  /// ```
  TextStyle get textStyle =>
      textTheme.body2.copyWith(fontSize: defaultFontSize);

  /// The color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get color => textTheme.textLow;

  /// The hover color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => textTheme.textHigh;

  /// The highlight color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get highlightColor => colorScheme.primary[highlightColorIndex];
}
