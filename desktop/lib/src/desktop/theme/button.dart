import 'dart:ui' show Brightness;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'constants.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kSidePadding = 4.0;
const double _kFilledSidePadding = 12.0;
const double _kHeight = 32.0;
const double _kMinWidth = 12.0;

@immutable
class ButtonThemeData {
  ///
  const ButtonThemeData({
    this.height,
    this.itemSpacing,
    this.filledSpacing,
    this.minWidth,
    this.textStyle,
    this.iconThemeData,
    this.disabledColor,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.focusBackground,
    this.highlightBackground,
    this.hoverBackground,
    this.foreground,
    this.highlightForeground,
    this.hoverForeground,
    this.axis,
  });

  final Axis? axis;

  final IconThemeData? iconThemeData;

  final double? itemSpacing;

  final double? filledSpacing;

  final double? height;

  final double? minWidth;

  final TextStyle? textStyle;

  final Color? disabledColor;

  final Color? color;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final Color? background;

  final Color? focusBackground;

  final Color? hoverBackground;

  final Color? highlightBackground;

  final Color? foreground;

  final Color? hoverForeground;

  final Color? highlightForeground;

  ButtonThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? filledSpacing,
    double? height,
    double? minWidth,
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
    Axis? axis,
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
      filledSpacing: filledSpacing ?? this.filledSpacing,
      background: background ?? this.background,
      focusBackground: focusBackground ?? this.focusBackground,
      highlightBackground: highlightBackground ?? this.highlightBackground,
      hoverBackground: hoverBackground ?? this.hoverBackground,
      foreground: foreground ?? this.foreground,
      highlightForeground: highlightForeground ?? this.highlightForeground,
      hoverForeground: hoverForeground ?? this.hoverForeground,
      axis: axis ??  this.axis,
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
      filledSpacing: other.filledSpacing,
      background: other.background,
      focusBackground: other.focusBackground,
      highlightBackground: other.highlightBackground,
      hoverBackground: other.hoverBackground,
      foreground: other.foreground,
      highlightForeground: other.highlightForeground,
      hoverForeground: other.hoverForeground,
      axis: other.axis,
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
        highlightColor != null &&
        filledSpacing != null &&
        background != null &&
        focusBackground != null &&
        hoverBackground != null &&
        highlightBackground != null &&
        foreground != null &&
        hoverForeground != null &&
        highlightForeground != null &&
        axis != null;
  }

  @override
  int get hashCode {
    return Object.hash(
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
      background,
      focusBackground,
      hoverBackground,
      highlightBackground,
      filledSpacing,
      foreground,
      hoverForeground,
      highlightForeground,
      axis,
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
        other.highlightColor == highlightColor &&
        other.filledSpacing == filledSpacing &&
        other.background == background &&
        other.focusBackground == focusBackground &&
        other.hoverBackground == hoverBackground &&
        other.highlightBackground == highlightBackground &&
        other.foreground == foreground &&
        other.hoverForeground == hoverForeground &&
        other.highlightForeground == highlightForeground &&
        other.axis == axis;
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

  /// Copies with the nearest [ButtonTheme].
  static Widget copyWith({
    Key? key,
    required Widget child,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? height,
    double? minWidth,
    Color? disabledColor,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? focusBackground,
    Color? hoverBackground,
    Color? highlightBackground,
    double? filledSpacing,
    Color? foreground,
    Color? hoverForeground,
    Color? highlightForeground,
    Axis? axis,
  }) {
    return Builder(
      key: key,
      builder: (context) => ButtonTheme(
        child: child,
        data: ButtonTheme.of(context).copyWith(
          textStyle: textStyle,
          iconThemeData: iconThemeData,
          itemSpacing: itemSpacing,
          height: height,
          minWidth: minWidth,
          disabledColor: disabledColor,
          color: color,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          filledSpacing: filledSpacing,
          background: background,
          focusBackground: focusBackground,
          highlightBackground: highlightBackground,
          hoverBackground: hoverBackground,
          foreground: foreground,
          hoverForeground: hoverForeground,
          highlightForeground: highlightForeground,
          axis: axis,
        ),
      ),
    );
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ButtonTheme? buttonTheme =
        context.findAncestorWidgetOfExactType<ButtonTheme>();
    return identical(this, buttonTheme)
        ? child
        : ButtonTheme(data: data, child: child);
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
          textTheme.body2.copyWith(
            fontSize: kFontSize,
            overflow: TextOverflow.ellipsis,
          );

      final Color color = buttonThemeData.color ?? textTheme.textLow;

      final Color hoverColor = buttonThemeData.hoverColor ?? textTheme.textHigh;

      final Color highlightColor = buttonThemeData.highlightColor ??
          colorScheme.primary[kHighlightColorIndex];

      final Color disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;

      final Color focusColor = hoverColor; // TODO(as): ???

      final Color background =
          buttonThemeData.background ?? colorScheme.primary[30];

      final Color hoverBackground =
          buttonThemeData.hoverBackground ?? colorScheme.shade[30];

      final Color highlightBackground =
          buttonThemeData.highlightBackground ?? colorScheme.background[20];

      // TODO(as): Unused.
      final Color focusBackground =
          buttonThemeData.focusBackground ?? colorScheme.shade[100];

      final Color foreground = buttonThemeData.foreground ?? textTheme.textHigh;

      final Color hoverForeground =
          buttonThemeData.hoverForeground ?? textTheme.textHigh;

      final Color highlightForeground =
          buttonThemeData.highlightForeground ?? textTheme.textHigh;

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: kIconSize, color: color);

      final double height = buttonThemeData.height ?? _kHeight;
      final double itemSpacing = buttonThemeData.itemSpacing ?? _kSidePadding;
      final double minWidth = buttonThemeData.minWidth ?? _kMinWidth;

      final double filledPadding =
          buttonThemeData.filledSpacing ?? _kFilledSidePadding;

      final Axis axis = buttonThemeData.axis ?? Axis.horizontal;

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
        filledSpacing: filledPadding,
        background: background,
        focusBackground: focusBackground,
        highlightBackground: highlightBackground,
        hoverBackground: hoverBackground,
        foreground: foreground,
        hoverForeground: hoverForeground,
        highlightForeground: highlightForeground,
        axis: axis,
      );
    }

    assert(buttonThemeData.isConcrete);

    return buttonThemeData;
  }

  @override
  bool updateShouldNotify(ButtonTheme oldWidget) => data != oldWidget.data;
}
