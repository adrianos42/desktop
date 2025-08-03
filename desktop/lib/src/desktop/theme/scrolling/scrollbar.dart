import 'package:flutter/widgets.dart';

import '../color_scheme.dart';

part 'scrollbar.g.dart';

/// Theme data for [Scrollbar].
@immutable
class _ScrollbarThemeData {
  const _ScrollbarThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  ColorScheme get _colorScheme => _themeData.colorScheme;

  ///
  Color get disabledColor => _colorScheme.disabled;

  ///
  Color get color => _colorScheme.shade[30].withValues(alpha: 0.8);

  ///
  Color get hoverColor => _colorScheme.shade[50].withValues(alpha: 0.8);

  ///
  Color get highlightColor => _colorScheme.shade[40].withValues(alpha: 0.8);

  ///
  Color get inhoverColor => _colorScheme.shade[70];

  ///
  Color get foreground => _colorScheme.shade[100];

  ///
  Color get trackColor => const Color(0x00000000);
}
