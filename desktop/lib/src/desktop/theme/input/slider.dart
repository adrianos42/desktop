import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'slider.g.dart';

/// Theme data for [Slider].
@immutable
class _SliderThemeData {
  const _SliderThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  ///
  Color get disabledColor => colorScheme.disabled;

  ///
  Color get activeColor => colorScheme.primary[kHighlightColorIndex];

  ///
  Color get activeHoverColor => textTheme.textHigh;

  ///
  Color get trackColor => colorScheme.shade[kItemBackgroundIndex];

  ///
  Color get hightlightColor => textTheme.textLow;
}
