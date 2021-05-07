import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'constants.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kSidePadding = 4.0;
const double _kHeight = 32.0;
const double _kFontSize = 14.0;
const double _kMinWidth = 12.0;

@immutable
class ButtonThemeData {
  const ButtonThemeData({
    this.height,
    this.itemSpacing,
    this.minWidth,
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

  final double? itemSpacing;

  final double? height;

  final double? minWidth;

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
    double? itemSpacing,
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
      itemSpacing: itemSpacing ?? this.itemSpacing,
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
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
      itemSpacing: other.itemSpacing,
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
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        itemSpacing != null &&
        height != null &&
        minWidth != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return hashValues(
      textStyle,
      iconThemeData,
      itemSpacing,
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
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ButtonThemeData &&
        other.textStyle == textStyle &&
        other.iconThemeData == iconThemeData &&
        other.itemSpacing == itemSpacing &&
        other.height == height &&
        other.minWidth == minWidth &&
        other.disabledColor == disabledColor &&
        other.color == color &&
        other.focusColor == focusColor &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor;
  }
}

@immutable
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

      final HSLColor color = buttonThemeData.color ?? textTheme.textLow;

      final HSLColor hoverColor =
          buttonThemeData.hoverColor ?? textTheme.textHigh;

      final HSLColor highlightColor =
          buttonThemeData.highlightColor ?? textTheme.textPrimary;

      final HSLColor disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;

      final HSLColor focusColor = hoverColor; // TODO(as): ???

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: kIconSize, color: color.toColor());

      final double height = buttonThemeData.height ?? _kHeight;
      final double itemSpacing = buttonThemeData.itemSpacing ?? _kSidePadding;
      final double minWidth = buttonThemeData.minWidth ?? _kMinWidth;

      buttonThemeData = buttonThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        disabledColor: disabledColor,
        color: color,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        height: height,
        itemSpacing: itemSpacing,
        minWidth: minWidth,
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
