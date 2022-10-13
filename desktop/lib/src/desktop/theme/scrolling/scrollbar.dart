import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_data.dart';
import '../theme_text.dart';

part 'scrollbar.g.dart';

/// Theme data for [Scrollbar].
@immutable
class _ScrollbarThemeData {
  const _ScrollbarThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  ///
  Color get disabledColor => colorScheme.disabled;

  ///
  Color get color => colorScheme.shade[30].withOpacity(0.8);

  ///
  Color get hoverColor => colorScheme.shade[50].withOpacity(0.8);

  ///
  Color get highlightColor => colorScheme.shade[40].withOpacity(0.8);

  ///
  Color get inhoverColor => colorScheme.shade[70];

  ///
  Color get foreground => colorScheme.shade[100];

  ///
  Color get trackColor => const Color(0x00000000);
}
