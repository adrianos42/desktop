// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Tooltip].
@immutable
class TooltipThemeData {
  /// Creates a [TooltipThemeData].
  const TooltipThemeData({
    this.height,
    this.maxWidth,
    this.verticalOffset,
    this.backgroundColor,
    this.textStyle,
    this.padding,
    this.margin,
    this.showDuration,
    this.waitDuration,
  });

  /// The height of the tooltip's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  final double? height;

  /// The max width for the tooltip.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 320.0
  /// ```
  final double? maxWidth;

  /// The vertical gap between the widget and the displayed tooltip.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 24.0
  /// ```
  final double? verticalOffset;

  /// The background color for the tooltip.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? backgroundColor;

  /// The [TextStyle] for the tooltip text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.caption
  /// ```
  final TextStyle? textStyle;

  /// The amount of space by which to inset the tooltip's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
  /// ```
  final EdgeInsetsGeometry? padding;

  /// The empty space that surrounds the tooltip
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.zero
  /// ```
  final EdgeInsetsGeometry? margin;

  /// The length of time that the tooltip will be shown after a long press
  /// is released.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 2400)
  /// ```
  final Duration? showDuration;

  /// The length of time that a pointer must hover over a tooltip's widget
  /// before the tooltip will be shown.
  ///
  /// Once the pointer leaves the widget, the tooltip will immediately
  /// disappear.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 1200)
  /// ```
  final Duration? waitDuration;

  /// Makes a copy of [TooltipThemeData] overwriting selected fields.
  TooltipThemeData copyWith({
    double? height,
    double? maxWidth,
    double? verticalOffset,
    Color? backgroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Duration? showDuration,
    Duration? waitDuration,
  }) {
    return TooltipThemeData(
      height: height ?? this.height,
      maxWidth: maxWidth ?? this.maxWidth,
      verticalOffset: verticalOffset ?? this.verticalOffset,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      showDuration: showDuration ?? this.showDuration,
      waitDuration: waitDuration ?? this.waitDuration,
    );
  }

  /// Merges the theme data [TooltipThemeData].
  TooltipThemeData merge(TooltipThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      maxWidth: other.maxWidth,
      verticalOffset: other.verticalOffset,
      backgroundColor: other.backgroundColor,
      textStyle: other.textStyle,
      padding: other.padding,
      margin: other.margin,
      showDuration: other.showDuration,
      waitDuration: other.waitDuration,
    );
  }

  bool get _isConcrete {
    return height != null &&
        maxWidth != null &&
        verticalOffset != null &&
        backgroundColor != null &&
        textStyle != null &&
        padding != null &&
        margin != null &&
        showDuration != null &&
        waitDuration != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      height,
      maxWidth,
      verticalOffset,
      backgroundColor,
      textStyle,
      padding,
      margin,
      showDuration,
      waitDuration,
    );
  }

  @override
  String toString() {
    return r'''
height: The height of the tooltip's [child].

 Defaults to:

 ```dart
 32.0
 ```;;maxWidth: The max width for the tooltip.

 Defaults to:

 ```dart
 320.0
 ```;;verticalOffset: The vertical gap between the widget and the displayed tooltip.

 Defaults to:

 ```dart
 24.0
 ```;;backgroundColor: The background color for the tooltip.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;textStyle: The [TextStyle] for the tooltip text.
 
 Defaults to:
 
 ```dart
 textTheme.caption
 ```;;padding: The amount of space by which to inset the tooltip's [child].

 Defaults to:

 ```dart
 EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
 ```;;margin: The empty space that surrounds the tooltip

 Defaults to:

 ```dart
 EdgeInsets.zero
 ```;;showDuration: The length of time that the tooltip will be shown after a long press
 is released.

 Defaults to:

 ```dart
 Duration(milliseconds: 2400)
 ```;;waitDuration: The length of time that a pointer must hover over a tooltip's widget
 before the tooltip will be shown.

 Once the pointer leaves the widget, the tooltip will immediately
 disappear.

 Defaults to:

 ```dart
 Duration(milliseconds: 1200)
 ```;;
''';
  }

  @override
  bool operator ==(covariant TooltipThemeData other) {
    return identical(this, other) ||
        other.height == height &&
            other.maxWidth == maxWidth &&
            other.verticalOffset == verticalOffset &&
            other.backgroundColor == backgroundColor &&
            other.textStyle == textStyle &&
            other.padding == padding &&
            other.margin == margin &&
            other.showDuration == showDuration &&
            other.waitDuration == waitDuration;
  }
}

/// Inherited theme for [TooltipThemeData].
@immutable
class TooltipTheme extends InheritedTheme {
  /// Creates a [TooltipTheme].
  const TooltipTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [TooltipTheme].
  final TooltipThemeData data;

  /// Merges the nearest [TooltipTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required TooltipThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => TooltipTheme(
        data: TooltipTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [TooltipTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    double? height,
    double? maxWidth,
    double? verticalOffset,
    Color? backgroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Duration? showDuration,
    Duration? waitDuration,
  }) {
    return Builder(
      key: key,
      builder: (context) => TooltipTheme(
        data: TooltipTheme.of(context).copyWith(
          height: height,
          maxWidth: maxWidth,
          verticalOffset: verticalOffset,
          backgroundColor: backgroundColor,
          textStyle: textStyle,
          padding: padding,
          margin: margin,
          showDuration: showDuration,
          waitDuration: waitDuration,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [TooltipTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final TooltipTheme? tooltipTheme =
        context.findAncestorWidgetOfExactType<TooltipTheme>();
    return identical(this, tooltipTheme)
        ? child
        : TooltipTheme(data: data, child: child);
  }

  /// Returns the nearest [TooltipTheme].
  static TooltipThemeData of(BuildContext context) {
    final TooltipTheme? tooltipTheme =
        context.dependOnInheritedWidgetOfExactType<TooltipTheme>();
    TooltipThemeData? tooltipThemeData = tooltipTheme?.data;

    if (tooltipThemeData == null || !tooltipThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context).invertedTheme;
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      tooltipThemeData ??= themeData.tooltipTheme;

      final tooltipValue =
          _TooltipThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final double height = tooltipThemeData.height ?? tooltipValue.height;
      final double maxWidth =
          tooltipThemeData.maxWidth ?? tooltipValue.maxWidth;
      final double verticalOffset =
          tooltipThemeData.verticalOffset ?? tooltipValue.verticalOffset;
      final Color backgroundColor =
          tooltipThemeData.backgroundColor ?? tooltipValue.backgroundColor;
      final TextStyle textStyle =
          tooltipThemeData.textStyle ?? tooltipValue.textStyle;
      final EdgeInsetsGeometry padding =
          tooltipThemeData.padding ?? tooltipValue.padding;
      final EdgeInsetsGeometry margin =
          tooltipThemeData.margin ?? tooltipValue.margin;
      final Duration showDuration =
          tooltipThemeData.showDuration ?? tooltipValue.showDuration;
      final Duration waitDuration =
          tooltipThemeData.waitDuration ?? tooltipValue.waitDuration;

      return tooltipThemeData.copyWith(
        height: height,
        maxWidth: maxWidth,
        verticalOffset: verticalOffset,
        backgroundColor: backgroundColor,
        textStyle: textStyle,
        padding: padding,
        margin: margin,
        showDuration: showDuration,
        waitDuration: waitDuration,
      );
    }

    assert(tooltipThemeData._isConcrete);

    return tooltipThemeData;
  }

  @override
  bool updateShouldNotify(TooltipTheme oldWidget) => data != oldWidget.data;
}
