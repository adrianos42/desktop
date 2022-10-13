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

  ///
  Color get disabledColor => colorScheme.disabled;

  ///
  Color get activeColor => colorScheme.primary[50];

  ///
  Color get activeHoverColor => colorScheme.primary[60];

  ///
  Color get inactiveColor => colorScheme.shade[50];

  ///
  Color get inactiveHoverColor => colorScheme.shade[100];

  ///
  Color get foreground => colorScheme.shade[100];
}
