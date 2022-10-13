import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'hyperlink.g.dart';

const double _kLineThickness = 1.0;
const HSLColor _kDefaultColor = HSLColor.fromAHSL(1.0, 210, 0.9, 0.56);

/// Theme data for [HyperlinkButton].
@immutable
class _HyperlinkThemeData {
  const _HyperlinkThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  ///
  Color get color => _kDefaultColor.toColor();

  ///
  Color get hoverColor => textTheme.textHigh;

  ///
  TextStyle get textStyle => textTheme.body2.copyWith(
        fontSize: 14.0,
        decoration: TextDecoration.underline,
        decorationThickness: _kLineThickness,
        overflow: TextOverflow.ellipsis,
      );

  ///
  Color get highlightColor => textTheme.textLow;
}
