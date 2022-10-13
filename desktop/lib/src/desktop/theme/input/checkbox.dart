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

  ///
  double get containerSize => _kContainerSize;
}
