import 'dart:ui' show Brightness;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'constants.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kSidePadding = 4.0;
const double _kHeight = 32.0;
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

  final Color? disabledColor;

  final Color? color;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  ButtonThemeData copyWith({
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

  /// Returns a proper custom color.
  Color customColor(BuildContext context, Color color) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (colorScheme.brightness) {
      case Brightness.dark:
        return HSLColor.fromColor(color).withLightness(0.6).toColor();
      case Brightness.light:
        return HSLColor.fromColor(color).withLightness(0.4).toColor();
    }
  }

  /// Returns a proper custom hover color.
  Color customHoverColor(BuildContext context, Color color) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (colorScheme.brightness) {
      case Brightness.dark:
        return HSLColor.fromColor(color).withLightness(0.8).toColor();
      case Brightness.light:
        return HSLColor.fromColor(color).withLightness(0.2).toColor();
    }
  }

  /// Returns a proper custom highlight color.
  Color customHighlightColor(BuildContext context, Color color) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (colorScheme.brightness) {
      case Brightness.dark:
        return HSLColor.fromColor(color).withLightness(0.6).toColor();
      case Brightness.light:
        return HSLColor.fromColor(color).withLightness(0.4).toColor();
    }
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

      final Color color =
          buttonThemeData.color ?? colorScheme.shade[kInactiveColorIndex];

      final Color hoverColor =
          buttonThemeData.hoverColor ?? colorScheme.shade[kHoverColorIndex];

      final Color highlightColor = buttonThemeData.highlightColor ??
          colorScheme.primary[kHighlightColorIndex];

      final Color disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;

      final Color focusColor = hoverColor; // TODO(as): ???

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: kIconSize, color: color);

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
}
