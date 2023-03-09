import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'slider.g.dart';

/// Theme data for [Slider].
@immutable
class _SliderThemeData {
  const _SliderThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The disabled color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get disabledColor => colorScheme.disabled;

  /// The active color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get activeColor => colorScheme.primary[kHighlightColorIndex];

  /// The active hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get activeHoverColor => textTheme.textHigh;

  /// The track color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  Color get trackColor => colorScheme.shade[kItemBackgroundIndex];

  /// The highlight color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get hightlightColor => textTheme.textLow;
}
