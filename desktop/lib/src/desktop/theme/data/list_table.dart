import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'list_table.g.dart';

const double _kDefaultItemHeight = 34.0;

/// Theme data for [ListTable].
@immutable
class _ListTableThemeData {
  const _ListTableThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  ///
  IconThemeData get iconThemeData =>
      IconThemeData(size: kDefaultIconSize, color: textTheme.textHigh);

  ///
  double get itemHeight => _kDefaultItemHeight;

  ///
  TextStyle get textStyle => textTheme.body1.copyWith(fontSize: kDefaultFontSize);

  ///
  Color get selectedColor => colorScheme.primary[30];

  ///
  Color get selectedHighlightColor => colorScheme.primary[60];

  ///
  Color get selectedHoverColor => colorScheme.primary[30];

  ///
  Color get hoverColor => colorScheme.background[20];

  ///
  Color get highlightColor => colorScheme.background[12];

  ///
  Color get background => colorScheme.background[0];

  ///
  Color get borderColor => colorScheme.shade[40];

  ///
  Color get borderHoverColor => textTheme.textHigh;

  ///
  Color get borderHighlightColor => colorScheme.primary[50];

  ///
  Color get borderIndicatorColor => colorScheme.primary[50];
}
