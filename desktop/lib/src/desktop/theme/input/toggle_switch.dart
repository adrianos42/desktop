import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'toggle_switch.g.dart';

/// Theme data for [ToggleSwitch].
@immutable
class _ToggleSwitchThemeData {
  const _ToggleSwitchThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  ///
  Color get disabledColor => colorScheme.disabled;

  ///
  Color get activeColor => colorScheme.primary[50];

  ///
  Color get activeHoverColor => textTheme.textHigh;

  ///
  Color get inactiveColor => textTheme.textLow;

  ///
  Color get inactiveHoverColor => textTheme.textHigh;

  ///
  Color get foreground => colorScheme.shade[100];
}
