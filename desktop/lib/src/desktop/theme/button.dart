import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kSidePadding = 6.0;
const double _kHeight = 32.0;
const double _kIconSize = 20.0;
const double _kFontSize = 14.0;
const double _kMinWidth = 12.0;

class ButtonThemeData {
  const ButtonThemeData({
    //this.colorScheme,
    this.height = _kHeight,
    this.leadingPadding = const EdgeInsets.only(left: _kSidePadding),
    this.trailingPadding = const EdgeInsets.only(right: _kSidePadding),
    this.bodyPadding = const EdgeInsets.symmetric(horizontal: _kSidePadding),
    this.buttonPadding = const EdgeInsets.symmetric(horizontal: _kSidePadding),
    this.minWidth = _kMinWidth,
    this.textStyle,
    this.iconThemeData,
    this.disabledColor,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
  });

  final IconThemeData? iconThemeData;

  //final ColorScheme colorScheme;

  final EdgeInsets leadingPadding;

  final EdgeInsets trailingPadding;

  final EdgeInsets bodyPadding;

  final EdgeInsets buttonPadding;

  final double height;

  final double minWidth;

  final TextStyle? textStyle;

  final HSLColor? disabledColor;

  final HSLColor? color;

  final HSLColor? focusColor;

  final HSLColor? hoverColor;

  final HSLColor? highlightColor;

  ButtonThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    EdgeInsets? leadingPadding,
    EdgeInsets? trailingPadding,
    EdgeInsets? bodyPadding,
    EdgeInsets? buttonPadding,
    double? height,
    double? minWidth,
    HSLColor? disabledColor,
    HSLColor? color,
    HSLColor? focusColor,
    HSLColor? hoverColor,
    HSLColor? highlightColor,
  }) {
    return ButtonThemeData(
      textStyle: textStyle ?? this.textStyle,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      //colorScheme: colorScheme ?? this.colorScheme,
      leadingPadding: leadingPadding ?? this.leadingPadding,
      trailingPadding: trailingPadding ?? this.trailingPadding,
      bodyPadding: bodyPadding ?? this.bodyPadding,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      disabledColor: disabledColor ?? this.disabledColor,
      color: color ?? this.color,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  ButtonThemeData merge(ButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
      //colorScheme: other.colorScheme,
      leadingPadding: other.leadingPadding,
      trailingPadding: other.trailingPadding,
      bodyPadding: other.bodyPadding,
      buttonPadding: other.buttonPadding,
      height: other.height,
      minWidth: other.minWidth,
      disabledColor: other.disabledColor,
      color: other.color,
      focusColor: other.focusColor,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
    );
  }

  bool get isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        //colorScheme != null &&
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return hashValues(
      textStyle,
      iconThemeData,
      //colorScheme,
      leadingPadding,
      trailingPadding,
      bodyPadding,
      buttonPadding,
      height,
      minWidth,
      disabledColor,
      color,
      focusColor,
      hoverColor,
      highlightColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ButtonThemeData &&
        other.textStyle == textStyle &&
        other.iconThemeData == iconThemeData &&
        other.leadingPadding == leadingPadding &&
        other.trailingPadding == trailingPadding &&
        other.bodyPadding == bodyPadding &&
        other.buttonPadding == buttonPadding &&
        other.height == height &&
        other.minWidth == minWidth &&
        other.disabledColor == disabledColor &&
        other.color == color &&
        other.focusColor == focusColor &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor;
  }
}

// Examples can assume:
class ButtonTheme extends InheritedTheme {
  const ButtonTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final ButtonThemeData data;

  static Widget merge({
    Key? key,
    required ButtonThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => ButtonTheme(
        key: key,
        data: ButtonTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static ButtonThemeData of(BuildContext context) {
    final ButtonTheme? buttonTheme =
        context.dependOnInheritedWidgetOfExactType<ButtonTheme>();
    ButtonThemeData? buttonThemeData = buttonTheme?.data;

    if (buttonThemeData == null || !buttonThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      buttonThemeData ??= themeData.buttonTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final TextStyle textStyle = buttonThemeData.textStyle ??
          textTheme.body2.copyWith(fontSize: _kFontSize);

      final HSLColor highlightColor =
          buttonThemeData.highlightColor ?? colorScheme.primary;

      final HSLColor hoverColor =
          buttonThemeData.hoverColor ?? textTheme.textHigh; // FIXME

      final HSLColor color = buttonThemeData.color ?? textTheme.textLow;

      final HSLColor disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;

      final HSLColor focusColor =
          buttonThemeData.focusColor ?? colorScheme.background4; // TODO

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: _kIconSize, color: color.toColor());

      buttonThemeData = buttonThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        disabledColor: disabledColor,
        color: color,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        leadingPadding: buttonThemeData.leadingPadding,
        trailingPadding: buttonThemeData.trailingPadding,
        bodyPadding: buttonThemeData.bodyPadding,
        buttonPadding: buttonThemeData.buttonPadding,
        height: buttonThemeData.height,
        minWidth: buttonThemeData.minWidth,
      );
    }

    assert(buttonThemeData.isConcrete);

    return buttonThemeData;
  }

  @override
  bool updateShouldNotify(ButtonTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ButtonTheme? buttonTheme =
        context.findAncestorWidgetOfExactType<ButtonTheme>();
    return identical(this, buttonTheme)
        ? child
        : ButtonTheme(data: data, child: child);
  }
}
