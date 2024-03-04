// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hyperlink.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [HyperlinkButton].
@immutable
class HyperlinkThemeData {
  /// Creates a [HyperlinkThemeData].
  const HyperlinkThemeData({
    this.color,
    this.hoverColor,
    this.textStyle,
    this.highlightColor,
  });

  /// The color of the hyperlink text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// PrimaryColors.dodgerBlue.primaryColor
  /// .withBrightness(colorScheme.brightness)
  /// .color
  /// ```
  final Color? color;

  /// The color of the hyperlink text when hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? hoverColor;

  /// The text style of the hyperlink.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(
  ///   fontSize: 14.0,
  ///   decoration: TextDecoration.underline,
  ///   decorationThickness: 1.0,
  ///   overflow: TextOverflow.ellipsis,
  /// )
  /// ```
  final TextStyle? textStyle;

  /// The color of the hyperlink text when highlighted.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? highlightColor;

  /// Makes a copy of [HyperlinkThemeData] overwriting selected fields.
  HyperlinkThemeData copyWith({
    Color? color,
    Color? hoverColor,
    TextStyle? textStyle,
    Color? highlightColor,
  }) {
    return HyperlinkThemeData(
      color: color ?? this.color,
      hoverColor: hoverColor ?? this.hoverColor,
      textStyle: textStyle ?? this.textStyle,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  /// Merges the theme data [HyperlinkThemeData].
  HyperlinkThemeData merge(HyperlinkThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      color: other.color,
      hoverColor: other.hoverColor,
      textStyle: other.textStyle,
      highlightColor: other.highlightColor,
    );
  }

  bool get _isConcrete {
    return color != null &&
        hoverColor != null &&
        textStyle != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      color,
      hoverColor,
      textStyle,
      highlightColor,
    );
  }

  @override
  String toString() {
    return r'''
color: The color of the hyperlink text.

 Defaults to:

 ```dart
 PrimaryColors.dodgerBlue.primaryColor
 .withBrightness(colorScheme.brightness)
 .color
 ```;;hoverColor: The color of the hyperlink text when hovered.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;textStyle: The text style of the hyperlink.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(
   fontSize: 14.0,
   decoration: TextDecoration.underline,
   decorationThickness: 1.0,
   overflow: TextOverflow.ellipsis,
 )
 ```;;highlightColor: The color of the hyperlink text when highlighted.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;
''';
  }

  @override
  bool operator ==(covariant HyperlinkThemeData other) {
    return identical(this, other) ||
        other.color == color &&
            other.hoverColor == hoverColor &&
            other.textStyle == textStyle &&
            other.highlightColor == highlightColor;
  }
}

/// Inherited theme for [HyperlinkThemeData].
@immutable
class HyperlinkTheme extends InheritedTheme {
  /// Creates a [HyperlinkTheme].
  const HyperlinkTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [HyperlinkTheme].
  final HyperlinkThemeData data;

  /// Merges the nearest [HyperlinkTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required HyperlinkThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => HyperlinkTheme(
        data: HyperlinkTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [HyperlinkTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Color? color,
    Color? hoverColor,
    TextStyle? textStyle,
    Color? highlightColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => HyperlinkTheme(
        data: HyperlinkTheme.of(context).copyWith(
          color: color,
          hoverColor: hoverColor,
          textStyle: textStyle,
          highlightColor: highlightColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [HyperlinkTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final HyperlinkTheme? hyperlinkTheme =
        context.findAncestorWidgetOfExactType<HyperlinkTheme>();
    return identical(this, hyperlinkTheme)
        ? child
        : HyperlinkTheme(data: data, child: child);
  }

  /// Returns the nearest [HyperlinkTheme].
  static HyperlinkThemeData of(BuildContext context) {
    final HyperlinkTheme? hyperlinkTheme =
        context.dependOnInheritedWidgetOfExactType<HyperlinkTheme>();
    HyperlinkThemeData? hyperlinkThemeData = hyperlinkTheme?.data;

    if (hyperlinkThemeData == null || !hyperlinkThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      hyperlinkThemeData ??= themeData.hyperlinkTheme;

      final hyperlinkValue =
          _HyperlinkThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final Color color = hyperlinkThemeData.color ?? hyperlinkValue.color;
      final Color hoverColor =
          hyperlinkThemeData.hoverColor ?? hyperlinkValue.hoverColor;
      final TextStyle textStyle =
          hyperlinkThemeData.textStyle ?? hyperlinkValue.textStyle;
      final Color highlightColor =
          hyperlinkThemeData.highlightColor ?? hyperlinkValue.highlightColor;

      return hyperlinkThemeData.copyWith(
        color: color,
        hoverColor: hoverColor,
        textStyle: textStyle,
        highlightColor: highlightColor,
      );
    }

    assert(hyperlinkThemeData._isConcrete);

    return hyperlinkThemeData;
  }

  @override
  bool updateShouldNotify(HyperlinkTheme oldWidget) => data != oldWidget.data;
}
