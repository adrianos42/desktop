import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'list_table.g.dart';

const double _kDefaultItemHeight = 34.0;

/// Theme data for [ListTable].
@immutable
class _ListTableThemeData {
  const _ListTableThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  ///
  IconThemeData get iconThemeData => IconThemeData(
    size: defaultIconSize,
    color: _textTheme.textHigh,
    fill: 1.0,
  );

  ///
  double get itemHeight => _kDefaultItemHeight;

  ///
  TextStyle get textStyle =>
      _textTheme.body1.copyWith(fontSize: defaultFontSize);

  ///
  Color get selectedColor => _colorScheme.primary[30];

  ///
  Color get selectedHighlightColor => _colorScheme.primary[60];

  ///
  Color get selectedHoverColor => _colorScheme.primary[30];

  ///
  Color get hoverColor => _colorScheme.background[20];

  ///
  Color get highlightColor => _colorScheme.background[12];

  ///
  Color get background => _colorScheme.background[0];

  ///
  Color get borderColor => _colorScheme.shade[40];

  ///
  Color get borderHoverColor => _textTheme.textHigh;

  ///
  Color get borderHighlightColor => _colorScheme.primary[50];

  ///
  Color get borderIndicatorColor => _colorScheme.primary[50];
}
