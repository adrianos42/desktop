import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'radio.g.dart';

/// Theme data for [Radio].
@immutable
class _RadioThemeData {
  const _RadioThemeData({
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
  /// colorScheme.primary[50]
  /// ```
  Color get activeColor => colorScheme.primary[50];

  /// The active hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get activeHoverColor => colorScheme.primary[60];

  /// The inactive color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[50]
  /// ```
  Color get inactiveColor => colorScheme.shade[50];

  /// The inactive hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get inactiveHoverColor => colorScheme.shade[100];

  /// The foreground color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get foreground => colorScheme.shade[100];
}
