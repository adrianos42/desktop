import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'theme_data.dart';
import 'color_scheme.dart';
import 'constants.dart';

const double _kLineThickness = 1.0;

class HyperlinkButtonThemeData {
  const HyperlinkButtonThemeData({
    this.color,
    this.hoverColor,
    this.textStyle,
  });

  final HSLColor? color;

  final HSLColor? hoverColor;

  final TextStyle? textStyle;

  HyperlinkButtonThemeData copyWidth({
    HSLColor? color,
    HSLColor? hoverColor,
    HSLColor? highlightColor,
    TextStyle? textStyle,
  }) {
    return HyperlinkButtonThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
      hoverColor: hoverColor ?? this.hoverColor,
    );
  }

  bool get isConcrete {
    return textStyle != null && color != null && hoverColor != null;
  }

  @override
  int get hashCode {
    return hashValues(
      color,
      textStyle,
      hoverColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is HyperlinkButtonThemeData &&
        other.color == color &&
        other.textStyle == textStyle &&
        other.hoverColor == hoverColor;
  }
}

class HyperlinkButtonTheme extends InheritedTheme {
  const HyperlinkButtonTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child);

  final HyperlinkButtonThemeData data;

  static HyperlinkButtonThemeData of(BuildContext context) {
    final HyperlinkButtonTheme? hyperlinkTheme =
        context.dependOnInheritedWidgetOfExactType<HyperlinkButtonTheme>();
    HyperlinkButtonThemeData? hyperlinkThemeData = hyperlinkTheme?.data;

    if (hyperlinkThemeData == null || hyperlinkThemeData.textStyle == null) {
      final ThemeData themeData = Theme.of(context);
      hyperlinkThemeData ??= themeData.hyperlinkButtonTheme;

      final TextStyle textStyle = hyperlinkThemeData.textStyle ??
          themeData.textTheme.body2.copyWith(
            fontSize: 14.0,
            decoration: TextDecoration.underline,
            decorationThickness: _kLineThickness,
          );

      final HSLColor color =
          hyperlinkThemeData.color ?? PrimaryColors.dodgerBlue;

      final HSLColor hoverColor = hyperlinkThemeData.hoverColor ??
          PrimaryColors.dodgerBlue
              .withLightness(PrimaryColors.dodgerBlue.lightness + 0.2);

      hyperlinkThemeData = hyperlinkThemeData.copyWidth(
        textStyle: textStyle,
        color: color,
        hoverColor: hoverColor,
      );
    }

    assert(hyperlinkThemeData.isConcrete);

    return hyperlinkThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final HyperlinkButtonTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<HyperlinkButtonTheme>();
    return identical(this, ancestorTheme)
        ? child
        : HyperlinkButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(HyperlinkButtonTheme oldWidget) =>
      data != oldWidget.data;
}
