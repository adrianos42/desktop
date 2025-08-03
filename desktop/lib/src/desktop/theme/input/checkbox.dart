import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'checkbox.g.dart';

const double _kContainerSize = 32.0;

/// Theme data for [Checkbox].
@immutable
class _CheckboxThemeData {
  const _CheckboxThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.contentTextTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;
  ColorScheme get _contentColorScheme => _themeData.contentColorScheme;

  bool get _isDark => _themeData.brightness == Brightness.dark;

  /// The disabled color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get disabledColor => _contentColorScheme.disabled;

  /// The active color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  Color get activeColor => _isDark ? _colorScheme.primary[50] : _textTheme.textHigh;

  /// The active hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get activeHoverColor =>  _textTheme.textLow;

  /// The inactive color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get inactiveColor => _isDark ? _textTheme.textLow : _textTheme.textHigh;

  /// The inactive hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get inactiveHoverColor => _isDark ? _textTheme.textHigh : _textTheme.textLow;

  /// The foreground color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get foreground => _colorScheme.shade[100];

  /// The hover foreground color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get hoverForeground => _contentColorScheme.background[0];

  /// The container size.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 32.0
  /// ```
  double get containerSize => _kContainerSize;
}
