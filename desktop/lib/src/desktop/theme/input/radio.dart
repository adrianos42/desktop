import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'radio.g.dart';

/// Theme data for [Radio].
@immutable
class _RadioThemeData {
  const _RadioThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  ColorScheme get _colorScheme => _themeData.contentColorScheme;
  TextTheme get _textTheme => _themeData.contentTextTheme;

  bool get _isDark => _themeData.brightness == Brightness.dark;

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
  /// colorScheme.primary[50]
  /// ```
  Color get activeColor =>
      _isDark ? _colorScheme.primary[50] : _textTheme.textHigh;

  /// The active hover color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => _textTheme.textHigh;

  /// The inactive color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get inactiveColor => _textTheme.textLow;

  /// The foreground color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get foreground => _colorScheme.shade[100];
}
