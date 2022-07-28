import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';
import 'constants.dart';

// TODO(as): ???
// const double _kSidePadding = 6.0;
// const double _kHeight = 32.0;
const double _kIconSize = 19.0;
const double _kFontSize = 14.0;
// const double _kMinWidth = 12.0;

@immutable
class DropDownButtonThemeData {
  const DropDownButtonThemeData({
    this.textStyle,
    this.iconThemeData,
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
  final IconThemeData? iconThemeData;

  final TextStyle? textStyle;

  /// The color of the border when disabled.
  final Color? disabledColor;

  /// The color of the border.
  final Color? color;

  /// The color of the border when focused.
  final Color? focusColor;

  /// The color of the border when hovered.
  final Color? hoverColor;

  /// The color of the border when the menu is open.
  final Color? waitingColor;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The background color when the button is being hovered.
  final Color? hoverBackgroundColor;

  /// The background color when the menu is open.
  final Color? waitingBackgroundColor;

  /// The background color when the button is disabled.
  final Color? disabledBackgroundColor;

  DropDownButtonThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
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
    return DropDownButtonThemeData(
        textStyle: textStyle ?? this.textStyle,
        iconThemeData: iconThemeData ?? this.iconThemeData,
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
            disabledBackgroundColor ?? this.disabledBackgroundColor);
  }

  DropDownButtonThemeData merge(DropDownButtonThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
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

  bool get isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        backgroundColor != null &&
        waitingColor != null &&
        hoverBackgroundColor != null &&
        waitingBackgroundColor != null &&
        disabledBackgroundColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      iconThemeData,
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
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DropDownButtonThemeData &&
        other.textStyle == textStyle &&
        other.iconThemeData == iconThemeData &&
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

@immutable
class DropDownButtonTheme extends InheritedTheme {
  const DropDownButtonTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final DropDownButtonThemeData data;

  static Widget merge({
    Key? key,
    required DropDownButtonThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => DropDownButtonTheme(
        key: key,
        data: DropDownButtonTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static DropDownButtonThemeData of(BuildContext context) {
    final DropDownButtonTheme? dropDownButtonTheme =
        context.dependOnInheritedWidgetOfExactType<DropDownButtonTheme>();
    DropDownButtonThemeData? buttonThemeData = dropDownButtonTheme?.data;

    if (buttonThemeData == null || !buttonThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      buttonThemeData ??= themeData.dropDownButtonTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final TextStyle textStyle = buttonThemeData.textStyle ??
          themeData.textTheme.body2.copyWith(
            fontSize: _kFontSize,
            color: textTheme.textMedium,
          );

      final Color color =
          buttonThemeData.color ?? colorScheme.shade[kInactiveColorIndex];

      final Color hoverColor =
          buttonThemeData.hoverColor ?? colorScheme.shade[kHoverColorIndex];

      final Color waitingColor =
          buttonThemeData.waitingColor ?? colorScheme.background[20];

      final Color backgroundColor =
          buttonThemeData.backgroundColor ?? colorScheme.background[0];

      final Color disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;
      final Color focusColor = buttonThemeData.focusColor ?? waitingColor;

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: _kIconSize, color: hoverColor);

      final Color hoverBackgroundColor =
          buttonThemeData.hoverBackgroundColor ?? colorScheme.background[0];

      final Color waitingBackgroundColor =
          buttonThemeData.waitingBackgroundColor ?? colorScheme.background[0];

      final Color disabledBackgroundColor =
          buttonThemeData.disabledBackgroundColor ?? colorScheme.background[0];

      buttonThemeData = buttonThemeData.copyWith(
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

    assert(buttonThemeData.isConcrete);

    return buttonThemeData;
  }

  static Widget copyWith({
    Key? key,
    required Widget child,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
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
      builder: (context) => DropDownButtonTheme(
        child: child,
        data: DropDownButtonTheme.of(context).copyWith(
          textStyle: textStyle,
          iconThemeData: iconThemeData,
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
      ),
    );
  }

  @override
  bool updateShouldNotify(DropDownButtonTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final DropDownButtonTheme? dropDownButtonTheme =
        context.findAncestorWidgetOfExactType<DropDownButtonTheme>();
    return identical(this, dropDownButtonTheme)
        ? child
        : DropDownButtonTheme(data: data, child: child);
  }
}
