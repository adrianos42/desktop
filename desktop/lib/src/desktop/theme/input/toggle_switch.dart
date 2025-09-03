import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'toggle_switch.g.dart';

/// Theme data for [ToggleSwitch].
@immutable
class _ToggleSwitchThemeData {
  const _ToggleSwitchThemeData(ThemeData themeData) : _themeData = themeData;

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
  /// colorScheme.primary[50]
  /// ```
  Color get activeColor => _colorScheme.primary[50];

  /// The active hover color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get activeHoverColor => _textTheme.textHigh;

  /// The inactive color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get inactiveColor => _textTheme.textLow;

  /// The inactive hover color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get inactiveHoverColor => _textTheme.textHigh;

  /// The foreground color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get foreground => _colorScheme.shade[100];
}
