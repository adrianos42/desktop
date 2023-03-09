import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'checkbox.g.dart';

const double _kContainerSize = 32.0;

/// Theme data for [Checkbox].
@immutable
class _CheckboxThemeData {
  const _CheckboxThemeData({
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
  /// textTheme.textLow
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
  /// textTheme.textHigh
  /// ```
  Color get activeHoverColor => textTheme.textHigh;

  /// The inactive color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get inactiveColor => textTheme.textLow;

  /// The inactive hover color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get inactiveHoverColor => textTheme.textHigh;

  /// The foreground color.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get foreground => colorScheme.shade[100];

  /// The container size.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 32.0
  /// ```
  double get containerSize => _kContainerSize;
}
