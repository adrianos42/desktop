import 'dart:ui' show Brightness;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'theme_data.dart';

const double _kLineThickness = 1.0;
const HSLColor _kDefaultColor = HSLColor.fromAHSL(1.0, 210, 0.9, 0.56);
const HSLColor _kDefaultLightColorHighlight =
    HSLColor.fromAHSL(1.0, 210, 0.9, 0.3);
const HSLColor _kDefaultDarkColorHighlight =
    HSLColor.fromAHSL(1.0, 210, 0.9, 0.8);

@immutable
class HyperlinkButtonThemeData {
  const HyperlinkButtonThemeData({
    this.color,
    this.hoverColor,
    this.textStyle,
    this.highlightColor,
  });

  final Color? color;

  final Color? hoverColor;

  final TextStyle? textStyle;

  final Color? highlightColor;

  HyperlinkButtonThemeData copyWidth({
    Color? color,
    Color? hoverColor,
    Color? highlightColor,
    TextStyle? textStyle,
  }) {
    return HyperlinkButtonThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  bool get isConcrete {
    return textStyle != null &&
        color != null &&
        hoverColor != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      color,
      textStyle,
      hoverColor,
      highlightColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is HyperlinkButtonThemeData &&
        other.color == color &&
        other.textStyle == textStyle &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor;
  }
}

@immutable
class HyperlinkButtonTheme extends InheritedTheme {
  const HyperlinkButtonTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

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
            overflow: TextOverflow.ellipsis,
          );

      final Color color = hyperlinkThemeData.color ?? _kDefaultColor.toColor();

      final Color hoverColor =
          hyperlinkThemeData.hoverColor ?? themeData.textTheme.textHigh;

      final Color highlightColor =
          hyperlinkThemeData.highlightColor ?? themeData.textTheme.textLow;

      hyperlinkThemeData = hyperlinkThemeData.copyWidth(
        textStyle: textStyle,
        color: color,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
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
