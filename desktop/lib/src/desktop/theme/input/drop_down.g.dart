// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_down.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Dropdown].
@immutable
class DropDownThemeData {
  /// Creates a [DropDownThemeData].
  const DropDownThemeData({
    this.iconThemeData,
    this.textStyle,
    this.disabledColor,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.waitingColor,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.waitingBackgroundColor,
    this.disabledBackgroundColor,
  });

  /// The icon theme of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: 19.0, color: hoverColor)
  /// ```
  final IconThemeData? iconThemeData;

  /// The style of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: 14.0, color: textTheme.textMedium)
  /// ```
  final TextStyle? textStyle;

  /// The color of the border when disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  final Color? disabledColor;

  /// The color of the border.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? color;

  /// The color of the border when focused.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// waitingColor
  /// ```
  final Color? focusColor;

  /// The color of the border when hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? hoverColor;

  /// The color of the border when the menu is open.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  final Color? waitingColor;

  /// The background color of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? backgroundColor;

  /// The background color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? hoverBackgroundColor;

  /// The background color when the menu is open.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? waitingBackgroundColor;

  /// The background color when the button is disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? disabledBackgroundColor;

  /// Makes a copy of [DropDownThemeData] overwriting selected fields.
  DropDownThemeData copyWith({
    IconThemeData? iconThemeData,
    TextStyle? textStyle,
    Color? disabledColor,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? waitingColor,
    Color? backgroundColor,
    Color? hoverBackgroundColor,
    Color? waitingBackgroundColor,
    Color? disabledBackgroundColor,
  }) {
    return DropDownThemeData(
      iconThemeData: iconThemeData ?? this.iconThemeData,
      textStyle: textStyle ?? this.textStyle,
      disabledColor: disabledColor ?? this.disabledColor,
      color: color ?? this.color,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      waitingColor: waitingColor ?? this.waitingColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      waitingBackgroundColor:
          waitingBackgroundColor ?? this.waitingBackgroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
    );
  }

  /// Merges the theme data [DropDownThemeData].
  DropDownThemeData merge(DropDownThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      iconThemeData: other.iconThemeData,
      textStyle: other.textStyle,
      disabledColor: other.disabledColor,
      color: other.color,
      focusColor: other.focusColor,
      hoverColor: other.hoverColor,
      waitingColor: other.waitingColor,
      backgroundColor: other.backgroundColor,
      hoverBackgroundColor: other.hoverBackgroundColor,
      waitingBackgroundColor: other.waitingBackgroundColor,
      disabledBackgroundColor: other.disabledBackgroundColor,
    );
  }

  bool get _isConcrete {
    return iconThemeData != null &&
        textStyle != null &&
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        waitingColor != null &&
        backgroundColor != null &&
        hoverBackgroundColor != null &&
        waitingBackgroundColor != null &&
        disabledBackgroundColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      iconThemeData,
      textStyle,
      disabledColor,
      color,
      focusColor,
      hoverColor,
      waitingColor,
      backgroundColor,
      hoverBackgroundColor,
      waitingBackgroundColor,
      disabledBackgroundColor,
    );
  }

  @override
  String toString() {
    return r'''
iconThemeData: The icon theme of the button.
 
 Defaults to:
 
 ```dart
 IconThemeData(size: 19.0, color: hoverColor)
 ```;;textStyle: The style of the button.
 
 Defaults to:
 
 ```dart
 textTheme.body2.copyWith(fontSize: 14.0, color: textTheme.textMedium)
 ```;;disabledColor: The color of the border when disabled.
 
 Defaults to:
 
 ```dart
 colorScheme.disabled
 ```;;color: The color of the border.
 
 Defaults to:
 
 ```dart
 textTheme.textLow
 ```;;focusColor: The color of the border when focused.
 
 Defaults to:
 
 ```dart
 waitingColor
 ```;;hoverColor: The color of the border when hovered.
 
 Defaults to:
 
 ```dart
 textTheme.textHigh
 ```;;waitingColor: The color of the border when the menu is open.
 
 Defaults to:
 
 ```dart
 colorScheme.background[20]
 ```;;backgroundColor: The background color of the button.
 
 Defaults to:
 
 ```dart
 colorScheme.background[0]
 ```;;hoverBackgroundColor: The background color when the button is being hovered.
 
 Defaults to:
 
 ```dart
 colorScheme.background[0]
 ```;;waitingBackgroundColor: The background color when the menu is open.
 
 Defaults to:
 
 ```dart
 colorScheme.background[0]
 ```;;disabledBackgroundColor: The background color when the button is disabled.
 
 Defaults to:
 
 ```dart
 colorScheme.background[0]
 ```;;
''';
  }

  @override
  bool operator ==(covariant DropDownThemeData other) {
    return identical(this, other) ||
        other.iconThemeData == iconThemeData &&
            other.textStyle == textStyle &&
            other.disabledColor == disabledColor &&
            other.color == color &&
            other.focusColor == focusColor &&
            other.hoverColor == hoverColor &&
            other.waitingColor == waitingColor &&
            other.backgroundColor == backgroundColor &&
            other.hoverBackgroundColor == hoverBackgroundColor &&
            other.waitingBackgroundColor == waitingBackgroundColor &&
            other.disabledBackgroundColor == disabledBackgroundColor;
  }
}

/// Inherited theme for [DropDownThemeData].
@immutable
class DropDownTheme extends InheritedTheme {
  /// Creates a [DropDownTheme].
  const DropDownTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [DropDownTheme].
  final DropDownThemeData data;

  /// Merges the nearest [DropDownTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required DropDownThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => DropDownTheme(
        data: DropDownTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [DropDownTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    IconThemeData? iconThemeData,
    TextStyle? textStyle,
    Color? disabledColor,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? waitingColor,
    Color? backgroundColor,
    Color? hoverBackgroundColor,
    Color? waitingBackgroundColor,
    Color? disabledBackgroundColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => DropDownTheme(
        data: DropDownTheme.of(context).copyWith(
          iconThemeData: iconThemeData,
          textStyle: textStyle,
          disabledColor: disabledColor,
          color: color,
          focusColor: focusColor,
          hoverColor: hoverColor,
          waitingColor: waitingColor,
          backgroundColor: backgroundColor,
          hoverBackgroundColor: hoverBackgroundColor,
          waitingBackgroundColor: waitingBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [DropDownTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final DropDownTheme? dropDownTheme =
        context.findAncestorWidgetOfExactType<DropDownTheme>();
    return identical(this, dropDownTheme)
        ? child
        : DropDownTheme(data: data, child: child);
  }

  /// Returns the nearest [DropDownTheme].
  static DropDownThemeData of(BuildContext context) {
    final DropDownTheme? dropDownTheme =
        context.dependOnInheritedWidgetOfExactType<DropDownTheme>();
    DropDownThemeData? dropDownThemeData = dropDownTheme?.data;

    if (dropDownThemeData == null || !dropDownThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      dropDownThemeData ??= themeData.dropDownTheme;

      final _dropDownThemeData =
          _DropDownThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final IconThemeData iconThemeData =
          dropDownThemeData.iconThemeData ?? _dropDownThemeData.iconThemeData;
      final TextStyle textStyle =
          dropDownThemeData.textStyle ?? _dropDownThemeData.textStyle;
      final Color disabledColor =
          dropDownThemeData.disabledColor ?? _dropDownThemeData.disabledColor;
      final Color color = dropDownThemeData.color ?? _dropDownThemeData.color;
      final Color focusColor =
          dropDownThemeData.focusColor ?? _dropDownThemeData.focusColor;
      final Color hoverColor =
          dropDownThemeData.hoverColor ?? _dropDownThemeData.hoverColor;
      final Color waitingColor =
          dropDownThemeData.waitingColor ?? _dropDownThemeData.waitingColor;
      final Color backgroundColor = dropDownThemeData.backgroundColor ??
          _dropDownThemeData.backgroundColor;
      final Color hoverBackgroundColor =
          dropDownThemeData.hoverBackgroundColor ??
              _dropDownThemeData.hoverBackgroundColor;
      final Color waitingBackgroundColor =
          dropDownThemeData.waitingBackgroundColor ??
              _dropDownThemeData.waitingBackgroundColor;
      final Color disabledBackgroundColor =
          dropDownThemeData.disabledBackgroundColor ??
              _dropDownThemeData.disabledBackgroundColor;

      return dropDownThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        disabledColor: disabledColor,
        color: color,
        focusColor: focusColor,
        hoverColor: hoverColor,
        waitingColor: waitingColor,
        backgroundColor: backgroundColor,
        hoverBackgroundColor: hoverBackgroundColor,
        waitingBackgroundColor: waitingBackgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
      );
    }

    assert(dropDownThemeData._isConcrete);

    return dropDownThemeData;
  }

  @override
  bool updateShouldNotify(DropDownTheme oldWidget) => data != oldWidget.data;
}
