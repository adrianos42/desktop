// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floating_menu_bar.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [menu bar].
@immutable
class FloatingMenuBarThemeData {
  /// Creates a [FloatingMenuBarThemeData].
  const FloatingMenuBarThemeData({
    this.height,
    this.minWidth,
    this.backgroundColor,
    this.inactiveOpacity,
    this.foreground,
    this.textStyle,
    this.padding,
    this.margin,
    this.showDuration,
    this.waitDuration,
  });

  /// The height of the menu bar's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  final double? height;

  /// The max width for the menu bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 320.0
  /// ```
  final double? minWidth;

  /// The background color for the menu bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor.withValues(alpha: 0.8)
  /// ```
  final Color? backgroundColor;

  /// The menu bar opacity when inactive.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 0.8
  /// ```
  final double? inactiveOpacity;

  /// The foreground color for the menu bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? foreground;

  /// The [TextStyle] for the menu bar text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.caption
  /// ```
  final TextStyle? textStyle;

  /// The amount of space by which to inset the menu bar's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
  /// ```
  final EdgeInsetsGeometry? padding;

  /// The empty space that surrounds the menu bar
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.zero
  /// ```
  final EdgeInsetsGeometry? margin;

  /// The length of time that the menu bar will be shown after a long press
  /// is released.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 2400)
  /// ```
  final Duration? showDuration;

  /// The length of time that a pointer must hover over a menu bar's widget
  /// before the menu bar will be shown.
  ///
  /// Once the pointer leaves the widget, the menu bar will immediately
  /// disappear.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 1200)
  /// ```
  final Duration? waitDuration;

  /// Makes a copy of [FloatingMenuBarThemeData] overwriting selected fields.
  FloatingMenuBarThemeData copyWith({
    double? height,
    double? minWidth,
    Color? backgroundColor,
    double? inactiveOpacity,
    Color? foreground,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Duration? showDuration,
    Duration? waitDuration,
  }) {
    return FloatingMenuBarThemeData(
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      inactiveOpacity: inactiveOpacity ?? this.inactiveOpacity,
      foreground: foreground ?? this.foreground,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      showDuration: showDuration ?? this.showDuration,
      waitDuration: waitDuration ?? this.waitDuration,
    );
  }

  /// Merges the theme data [FloatingMenuBarThemeData].
  FloatingMenuBarThemeData merge(FloatingMenuBarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      minWidth: other.minWidth,
      backgroundColor: other.backgroundColor,
      inactiveOpacity: other.inactiveOpacity,
      foreground: other.foreground,
      textStyle: other.textStyle,
      padding: other.padding,
      margin: other.margin,
      showDuration: other.showDuration,
      waitDuration: other.waitDuration,
    );
  }

  bool get _isConcrete {
    return height != null &&
        minWidth != null &&
        backgroundColor != null &&
        inactiveOpacity != null &&
        foreground != null &&
        textStyle != null &&
        padding != null &&
        margin != null &&
        showDuration != null &&
        waitDuration != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      height,
      minWidth,
      backgroundColor,
      inactiveOpacity,
      foreground,
      textStyle,
      padding,
      margin,
      showDuration,
      waitDuration,
    ]);
  }

  @override
  String toString() {
    return r'''
height: The height of the menu bar's [child].

 Defaults to:

 ```dart
 32.0
 ```;;minWidth: The max width for the menu bar.

 Defaults to:

 ```dart
 320.0
 ```;;backgroundColor: The background color for the menu bar.

 Defaults to:

 ```dart
 hoverColor.withValues(alpha: 0.8)
 ```;;inactiveOpacity: The menu bar opacity when inactive.

 Defaults to:

 ```dart
 0.8
 ```;;foreground: The foreground color for the menu bar.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;textStyle: The [TextStyle] for the menu bar text.

 Defaults to:

 ```dart
 textTheme.caption
 ```;;padding: The amount of space by which to inset the menu bar's [child].

 Defaults to:

 ```dart
 EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
 ```;;margin: The empty space that surrounds the menu bar

 Defaults to:

 ```dart
 EdgeInsets.zero
 ```;;showDuration: The length of time that the menu bar will be shown after a long press
 is released.

 Defaults to:

 ```dart
 Duration(milliseconds: 2400)
 ```;;waitDuration: The length of time that a pointer must hover over a menu bar's widget
 before the menu bar will be shown.

 Once the pointer leaves the widget, the menu bar will immediately
 disappear.

 Defaults to:

 ```dart
 Duration(milliseconds: 1200)
 ```;;
''';
  }

  @override
  bool operator ==(covariant FloatingMenuBarThemeData other) {
    return identical(this, other) ||
        other.height == height &&
            other.minWidth == minWidth &&
            other.backgroundColor == backgroundColor &&
            other.inactiveOpacity == inactiveOpacity &&
            other.foreground == foreground &&
            other.textStyle == textStyle &&
            other.padding == padding &&
            other.margin == margin &&
            other.showDuration == showDuration &&
            other.waitDuration == waitDuration;
  }
}

/// Inherited theme for [FloatingMenuBarThemeData].
@immutable
class FloatingMenuBarTheme extends InheritedTheme {
  /// Creates a [FloatingMenuBarTheme].
  const FloatingMenuBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The data representing this [FloatingMenuBarTheme].
  final FloatingMenuBarThemeData data;

  /// Merges the nearest [FloatingMenuBarTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required FloatingMenuBarThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => FloatingMenuBarTheme(
        data: FloatingMenuBarTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [FloatingMenuBarTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    double? height,
    double? minWidth,
    Color? backgroundColor,
    double? inactiveOpacity,
    Color? foreground,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Duration? showDuration,
    Duration? waitDuration,
  }) {
    return Builder(
      key: key,
      builder: (context) => FloatingMenuBarTheme(
        data: FloatingMenuBarTheme.of(context).copyWith(
          height: height,
          minWidth: minWidth,
          backgroundColor: backgroundColor,
          inactiveOpacity: inactiveOpacity,
          foreground: foreground,
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

  /// Returns a copy of [FloatingMenuBarTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final FloatingMenuBarTheme? floatingMenuBarTheme = context
        .findAncestorWidgetOfExactType<FloatingMenuBarTheme>();
    return identical(this, floatingMenuBarTheme)
        ? child
        : FloatingMenuBarTheme(data: data, child: child);
  }

  /// Returns the nearest [FloatingMenuBarTheme].
  static FloatingMenuBarThemeData of(BuildContext context) {
    final FloatingMenuBarTheme? floatingMenuBarTheme = context
        .dependOnInheritedWidgetOfExactType<FloatingMenuBarTheme>();
    FloatingMenuBarThemeData? floatingMenuBarThemeData =
        floatingMenuBarTheme?.data;

    if (floatingMenuBarThemeData == null ||
        !floatingMenuBarThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      floatingMenuBarThemeData ??= themeData.floatingMenuBarTheme;

      final floatingMenuBarValue = _FloatingMenuBarThemeData(themeData);

      final double height =
          floatingMenuBarThemeData.height ?? floatingMenuBarValue.height;
      final double minWidth =
          floatingMenuBarThemeData.minWidth ?? floatingMenuBarValue.minWidth;
      final Color backgroundColor =
          floatingMenuBarThemeData.backgroundColor ??
          floatingMenuBarValue.backgroundColor;
      final double inactiveOpacity =
          floatingMenuBarThemeData.inactiveOpacity ??
          floatingMenuBarValue.inactiveOpacity;
      final Color foreground =
          floatingMenuBarThemeData.foreground ??
          floatingMenuBarValue.foreground;
      final TextStyle textStyle =
          floatingMenuBarThemeData.textStyle ?? floatingMenuBarValue.textStyle;
      final EdgeInsetsGeometry padding =
          floatingMenuBarThemeData.padding ?? floatingMenuBarValue.padding;
      final EdgeInsetsGeometry margin =
          floatingMenuBarThemeData.margin ?? floatingMenuBarValue.margin;
      final Duration showDuration =
          floatingMenuBarThemeData.showDuration ??
          floatingMenuBarValue.showDuration;
      final Duration waitDuration =
          floatingMenuBarThemeData.waitDuration ??
          floatingMenuBarValue.waitDuration;

      return floatingMenuBarThemeData.copyWith(
        height: height,
        minWidth: minWidth,
        backgroundColor: backgroundColor,
        inactiveOpacity: inactiveOpacity,
        foreground: foreground,
        textStyle: textStyle,
        padding: padding,
        margin: margin,
        showDuration: showDuration,
        waitDuration: waitDuration,
      );
    }

    assert(floatingMenuBarThemeData._isConcrete);

    return floatingMenuBarThemeData;
  }

  @override
  bool updateShouldNotify(FloatingMenuBarTheme oldWidget) =>
      data != oldWidget.data;
}
