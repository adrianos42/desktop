import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'theme_color.dart';
import 'constants.dart';

const Color _kHyperlinkDefaultForeground = Color(0xFF1C86EE);
const double _kLineThickness = 1.0;

class HyperlinkButtonThemeData {
  const HyperlinkButtonThemeData({
    this.color = _kHyperlinkDefaultForeground,
    this.textStyle,
  });

  final Color color;

  final TextStyle? textStyle;

  HyperlinkButtonThemeData copyWidth({
    Color? color,
    TextStyle? textStyle,
  }) {
    return HyperlinkButtonThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  bool get isConcrete {
    return textStyle != null;
  }

  @override
  int get hashCode {
    return hashValues(
      color,
      textStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is HyperlinkButtonThemeData &&
        other.color == color &&
        other.textStyle == textStyle;
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

      final TextStyle textStyle = themeData.textTheme.body1.copyWith(
        fontSize: 14.0,
        decoration: TextDecoration.underline,
        decorationThickness: _kLineThickness,
      );

      hyperlinkThemeData = hyperlinkThemeData.copyWidth(textStyle: textStyle);
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
