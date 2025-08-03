import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'slider.g.dart';

/// Theme data for [Slider].
@immutable
class _SliderThemeData {
  const _SliderThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  /// The disabled color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get disabledColor => _colorScheme.disabled;

  /// The active color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get activeColor =>_colorScheme.primary[highlightColorIndex];

  /// The active hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get activeHoverColor => _textTheme.textHigh;

  /// The track color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  Color get trackColor => _colorScheme.shade[itemBackgroundIndex];

  /// The highlight color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get hightlightColor => _textTheme.textLow;
}
