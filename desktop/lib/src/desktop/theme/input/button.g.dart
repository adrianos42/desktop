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
  /// textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
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
  /// colorScheme.primary[kHighlightColorIndex]
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

  /// The duraton of the animation.
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
    return Object.hash(
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
      focusBackground,
      hoverBackground,
      highlightBackground,
      foreground,
      hoverForeground,
      highlightForeground,
      animationDuration,
    );
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
 textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
 ```;;disabledColor: The color when the button is disabled.

 Defaults to:
 
 ```dart
 colorScheme.disabled
 ```;;color: The color when button is not filled.

 Defaults to:
 
 ```dart 
 colorScheme.primary[kHighlightColorIndex]
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
 ```;;animationDuration: The duraton of the animation.
 
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
  const ButtonTheme({
    super.key,
    required super.child,
    required this.data,
  });

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
      builder: (context) => ButtonTheme(
        data: ButtonTheme.of(context).merge(data),
        child: child,
      ),
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
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final ButtonTheme? buttonTheme =
        context.findAncestorWidgetOfExactType<ButtonTheme>();
    return identical(this, buttonTheme)
        ? child
        : ButtonTheme(data: data, child: child);
  }

  /// Returns the nearest [ButtonTheme].
  static ButtonThemeData of(BuildContext context) {
    final ButtonTheme? buttonTheme =
        context.dependOnInheritedWidgetOfExactType<ButtonTheme>();
    ButtonThemeData? buttonThemeData = buttonTheme?.data;

    if (buttonThemeData == null || !buttonThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      buttonThemeData ??= themeData.buttonTheme;

      final _buttonThemeData =
          _ButtonThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final Axis axis = buttonThemeData.axis ?? _buttonThemeData.axis;
      final IconThemeData iconThemeData =
          buttonThemeData.iconThemeData ?? _buttonThemeData.iconThemeData;
      final double itemSpacing =
          buttonThemeData.itemSpacing ?? _buttonThemeData.itemSpacing;
      final double filledSpacing =
          buttonThemeData.filledSpacing ?? _buttonThemeData.filledSpacing;
      final double height = buttonThemeData.height ?? _buttonThemeData.height;
      final double minWidth =
          buttonThemeData.minWidth ?? _buttonThemeData.minWidth;
      final TextStyle textStyle =
          buttonThemeData.textStyle ?? _buttonThemeData.textStyle;
      final Color disabledColor =
          buttonThemeData.disabledColor ?? _buttonThemeData.disabledColor;
      final Color color = buttonThemeData.color ?? _buttonThemeData.color;
      final Color focusColor =
          buttonThemeData.focusColor ?? _buttonThemeData.focusColor;
      final Color hoverColor =
          buttonThemeData.hoverColor ?? _buttonThemeData.hoverColor;
      final Color highlightColor =
          buttonThemeData.highlightColor ?? _buttonThemeData.highlightColor;
      final Color background =
          buttonThemeData.background ?? _buttonThemeData.background;
      final Color focusBackground =
          buttonThemeData.focusBackground ?? _buttonThemeData.focusBackground;
      final Color hoverBackground =
          buttonThemeData.hoverBackground ?? _buttonThemeData.hoverBackground;
      final Color highlightBackground = buttonThemeData.highlightBackground ??
          _buttonThemeData.highlightBackground;
      final Color foreground =
          buttonThemeData.foreground ?? _buttonThemeData.foreground;
      final Color hoverForeground =
          buttonThemeData.hoverForeground ?? _buttonThemeData.hoverForeground;
      final Color highlightForeground = buttonThemeData.highlightForeground ??
          _buttonThemeData.highlightForeground;
      final Duration animationDuration = buttonThemeData.animationDuration ??
          _buttonThemeData.animationDuration;

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
