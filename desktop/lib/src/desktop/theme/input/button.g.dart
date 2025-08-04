// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Button].
@immutable
class ButtonThemeData {
  /// Creates a [ButtonThemeData].
  const ButtonThemeData({
    this.axis,
    this.iconThemeData,
    this.itemSpacing,
    this.filledSpacing,
    this.height,
    this.minWidth,
    this.textStyle,
    this.disabledColor,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.disabledBackground,
    this.focusBackground,
    this.hoverBackground,
    this.highlightBackground,
    this.foreground,
    this.hoverForeground,
    this.highlightForeground,
    this.animationDuration,
  });

  /// The axis of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Axis.horizontal
  /// ```
  final Axis? axis;

  /// The icon theme data.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize, color: color)
  /// ```
  final IconThemeData? iconThemeData;

  /// Spacing used in body and button paddings.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 4.0
  /// ```
  final double? itemSpacing;

  /// Spacing used in body padding when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  final double? filledSpacing;

  /// The height of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  final double? height;

  /// The minimum width of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  final double? minWidth;

  /// The text style.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: defaultFontSize, overflow: TextOverflow.ellipsis)
  /// ```
  final TextStyle? textStyle;

  /// The color when the button is disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  final Color? disabledColor;

  /// The color when button is not filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  final Color? color;

  /// The color when the button has focus.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor
  /// ```
  final Color? focusColor;

  /// The color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? hoverColor;

  /// The color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? highlightColor;

  /// The background color when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[30]
  /// ```
  final Color? background;

  /// The background color when the button is disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  final Color? disabledBackground;

  /// The background color when the button is being focused.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? focusBackground;

  /// The background color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  final Color? hoverBackground;

  /// The background color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  final Color? highlightBackground;

  /// The foreground color when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? foreground;

  /// The foreground color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? hoverForeground;

  /// The foreground color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? highlightForeground;

  /// The duration of the animation.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 100)
  /// ```
  final Duration? animationDuration;

  /// Makes a copy of [ButtonThemeData] overwriting selected fields.
  ButtonThemeData copyWith({
    Axis? axis,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? filledSpacing,
    double? height,
    double? minWidth,
    TextStyle? textStyle,
    Color? disabledColor,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? disabledBackground,
    Color? focusBackground,
    Color? hoverBackground,
    Color? highlightBackground,
    Color? foreground,
    Color? hoverForeground,
    Color? highlightForeground,
    Duration? animationDuration,
  }) {
    return ButtonThemeData(
      axis: axis ?? this.axis,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      filledSpacing: filledSpacing ?? this.filledSpacing,
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      textStyle: textStyle ?? this.textStyle,
      disabledColor: disabledColor ?? this.disabledColor,
      color: color ?? this.color,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      background: background ?? this.background,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      focusBackground: focusBackground ?? this.focusBackground,
      hoverBackground: hoverBackground ?? this.hoverBackground,
      highlightBackground: highlightBackground ?? this.highlightBackground,
      foreground: foreground ?? this.foreground,
      hoverForeground: hoverForeground ?? this.hoverForeground,
      highlightForeground: highlightForeground ?? this.highlightForeground,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  /// Merges the theme data [ButtonThemeData].
  ButtonThemeData merge(ButtonThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      axis: other.axis,
      iconThemeData: other.iconThemeData,
      itemSpacing: other.itemSpacing,
      filledSpacing: other.filledSpacing,
      height: other.height,
      minWidth: other.minWidth,
      textStyle: other.textStyle,
      disabledColor: other.disabledColor,
      color: other.color,
      focusColor: other.focusColor,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      background: other.background,
      disabledBackground: other.disabledBackground,
      focusBackground: other.focusBackground,
      hoverBackground: other.hoverBackground,
      highlightBackground: other.highlightBackground,
      foreground: other.foreground,
      hoverForeground: other.hoverForeground,
      highlightForeground: other.highlightForeground,
      animationDuration: other.animationDuration,
    );
  }

  bool get _isConcrete {
    return axis != null &&
        iconThemeData != null &&
        itemSpacing != null &&
        filledSpacing != null &&
        height != null &&
        minWidth != null &&
        textStyle != null &&
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        highlightColor != null &&
        background != null &&
        disabledBackground != null &&
        focusBackground != null &&
        hoverBackground != null &&
        highlightBackground != null &&
        foreground != null &&
        hoverForeground != null &&
        highlightForeground != null &&
        animationDuration != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      axis,
      iconThemeData,
      itemSpacing,
      filledSpacing,
      height,
      minWidth,
      textStyle,
      disabledColor,
      color,
      focusColor,
      hoverColor,
      highlightColor,
      background,
      disabledBackground,
      focusBackground,
      hoverBackground,
      highlightBackground,
      foreground,
      hoverForeground,
      highlightForeground,
      animationDuration,
    ]);
  }

  @override
  String toString() {
    return r'''
axis: The axis of the button.

 Defaults to:

 ```dart
 Axis.horizontal
 ```;;iconThemeData: The icon theme data.

 Defaults to:

 ```dart
 IconThemeData(size: kDefaultIconSize, color: color)
 ```;;itemSpacing: Spacing used in body and button paddings.

 Defaults to:

 ```dart
 4.0
 ```;;filledSpacing: Spacing used in body padding when the button is filled.

 Defaults to:

 ```dart
 12.0
 ```;;height: The height of the button.

 Defaults to:

 ```dart
 32.0
 ```;;minWidth: The minimum width of the button.

 Defaults to:

 ```dart
 12.0
 ```;;textStyle: The text style.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(fontSize: defaultFontSize, overflow: TextOverflow.ellipsis)
 ```;;disabledColor: The color when the button is disabled.

 Defaults to:

 ```dart
 colorScheme.disabled
 ```;;color: The color when button is not filled.

 Defaults to:

 ```dart
 colorScheme.primary[60]
 ```;;focusColor: The color when the button has focus.

 Defaults to:

 ```dart
 hoverColor
 ```;;hoverColor: The color when the button is being hovered.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;highlightColor: The color when the button is pressed.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;background: The background color when the button is filled.

 Defaults to:

 ```dart
 colorScheme.primary[30]
 ```;;disabledBackground: The background color when the button is disabled.

 Defaults to:

 ```dart
 colorScheme.disabled
 ```;;focusBackground: The background color when the button is being focused.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;hoverBackground: The background color when the button is being hovered.

 Defaults to:

 ```dart
 colorScheme.shade[30]
 ```;;highlightBackground: The background color when the button is pressed.

 Defaults to:

 ```dart
 colorScheme.background[20]
 ```;;foreground: The foreground color when the button is filled.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;hoverForeground: The foreground color when the button is being hovered.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;highlightForeground: The foreground color when the button is pressed.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;animationDuration: The duration of the animation.

 Defaults to:

 ```dart
 Duration(milliseconds: 100)
 ```;;
''';
  }

  @override
  bool operator ==(covariant ButtonThemeData other) {
    return identical(this, other) ||
        other.axis == axis &&
            other.iconThemeData == iconThemeData &&
            other.itemSpacing == itemSpacing &&
            other.filledSpacing == filledSpacing &&
            other.height == height &&
            other.minWidth == minWidth &&
            other.textStyle == textStyle &&
            other.disabledColor == disabledColor &&
            other.color == color &&
            other.focusColor == focusColor &&
            other.hoverColor == hoverColor &&
            other.highlightColor == highlightColor &&
            other.background == background &&
            other.disabledBackground == disabledBackground &&
            other.focusBackground == focusBackground &&
            other.hoverBackground == hoverBackground &&
            other.highlightBackground == highlightBackground &&
            other.foreground == foreground &&
            other.hoverForeground == hoverForeground &&
            other.highlightForeground == highlightForeground &&
            other.animationDuration == animationDuration;
  }
}

/// Inherited theme for [ButtonThemeData].
@immutable
class ButtonTheme extends InheritedTheme {
  /// Creates a [ButtonTheme].
  const ButtonTheme({super.key, required super.child, required this.data});

  /// The data representing this [ButtonTheme].
  final ButtonThemeData data;

  /// Merges the nearest [ButtonTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required ButtonThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) =>
          ButtonTheme(data: ButtonTheme.of(context).merge(data), child: child),
    );
  }

  /// Makes a copy of the nearest [ButtonTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Axis? axis,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? filledSpacing,
    double? height,
    double? minWidth,
    TextStyle? textStyle,
    Color? disabledColor,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? disabledBackground,
    Color? focusBackground,
    Color? hoverBackground,
    Color? highlightBackground,
    Color? foreground,
    Color? hoverForeground,
    Color? highlightForeground,
    Duration? animationDuration,
  }) {
    return Builder(
      key: key,
      builder: (context) => ButtonTheme(
        data: ButtonTheme.of(context).copyWith(
          axis: axis,
          iconThemeData: iconThemeData,
          itemSpacing: itemSpacing,
          filledSpacing: filledSpacing,
          height: height,
          minWidth: minWidth,
          textStyle: textStyle,
          disabledColor: disabledColor,
          color: color,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          background: background,
          disabledBackground: disabledBackground,
          focusBackground: focusBackground,
          hoverBackground: hoverBackground,
          highlightBackground: highlightBackground,
          foreground: foreground,
          hoverForeground: hoverForeground,
          highlightForeground: highlightForeground,
          animationDuration: animationDuration,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [ButtonTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final ButtonTheme? buttonTheme = context
        .findAncestorWidgetOfExactType<ButtonTheme>();
    return identical(this, buttonTheme)
        ? child
        : ButtonTheme(data: data, child: child);
  }

  /// Returns the nearest [ButtonTheme].
  static ButtonThemeData of(BuildContext context) {
    final ButtonTheme? buttonTheme = context
        .dependOnInheritedWidgetOfExactType<ButtonTheme>();
    ButtonThemeData? buttonThemeData = buttonTheme?.data;

    if (buttonThemeData == null || !buttonThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      buttonThemeData ??= themeData.buttonTheme;

      final buttonValue = _ButtonThemeData(themeData);

      final Axis axis = buttonThemeData.axis ?? buttonValue.axis;
      final IconThemeData iconThemeData =
          buttonThemeData.iconThemeData ?? buttonValue.iconThemeData;
      final double itemSpacing =
          buttonThemeData.itemSpacing ?? buttonValue.itemSpacing;
      final double filledSpacing =
          buttonThemeData.filledSpacing ?? buttonValue.filledSpacing;
      final double height = buttonThemeData.height ?? buttonValue.height;
      final double minWidth = buttonThemeData.minWidth ?? buttonValue.minWidth;
      final TextStyle textStyle =
          buttonThemeData.textStyle ?? buttonValue.textStyle;
      final Color disabledColor =
          buttonThemeData.disabledColor ?? buttonValue.disabledColor;
      final Color color = buttonThemeData.color ?? buttonValue.color;
      final Color focusColor =
          buttonThemeData.focusColor ?? buttonValue.focusColor;
      final Color hoverColor =
          buttonThemeData.hoverColor ?? buttonValue.hoverColor;
      final Color highlightColor =
          buttonThemeData.highlightColor ?? buttonValue.highlightColor;
      final Color background =
          buttonThemeData.background ?? buttonValue.background;
      final Color disabledBackground =
          buttonThemeData.disabledBackground ?? buttonValue.disabledBackground;
      final Color focusBackground =
          buttonThemeData.focusBackground ?? buttonValue.focusBackground;
      final Color hoverBackground =
          buttonThemeData.hoverBackground ?? buttonValue.hoverBackground;
      final Color highlightBackground =
          buttonThemeData.highlightBackground ??
          buttonValue.highlightBackground;
      final Color foreground =
          buttonThemeData.foreground ?? buttonValue.foreground;
      final Color hoverForeground =
          buttonThemeData.hoverForeground ?? buttonValue.hoverForeground;
      final Color highlightForeground =
          buttonThemeData.highlightForeground ??
          buttonValue.highlightForeground;
      final Duration animationDuration =
          buttonThemeData.animationDuration ?? buttonValue.animationDuration;

      return buttonThemeData.copyWith(
        axis: axis,
        iconThemeData: iconThemeData,
        itemSpacing: itemSpacing,
        filledSpacing: filledSpacing,
        height: height,
        minWidth: minWidth,
        textStyle: textStyle,
        disabledColor: disabledColor,
        color: color,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        background: background,
        disabledBackground: disabledBackground,
        focusBackground: focusBackground,
        hoverBackground: hoverBackground,
        highlightBackground: highlightBackground,
        foreground: foreground,
        hoverForeground: hoverForeground,
        highlightForeground: highlightForeground,
        animationDuration: animationDuration,
      );
    }

    assert(buttonThemeData._isConcrete);

    return buttonThemeData;
  }

  @override
  bool updateShouldNotify(ButtonTheme oldWidget) => data != oldWidget.data;
}
