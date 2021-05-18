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
    this.inactiveColor,
  });

  final IconThemeData? iconThemeData;

  final TextStyle? textStyle;

  final HSLColor? disabledColor;

  final HSLColor? color;

  final HSLColor? focusColor;

  final HSLColor? hoverColor;

  final HSLColor? waitingColor;

  final HSLColor? inactiveColor;

  DropDownButtonThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    HSLColor? disabledColor,
    HSLColor? color,
    HSLColor? focusColor,
    HSLColor? hoverColor,
    HSLColor? waitingColor,
    HSLColor? inactiveColor,
  }) {
    return DropDownButtonThemeData(
      textStyle: textStyle ?? this.textStyle,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      disabledColor: disabledColor ?? this.disabledColor,
      color: color ?? this.color,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      waitingColor: waitingColor ?? this.waitingColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
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
      inactiveColor: other.inactiveColor,
    );
  }

  bool get isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        inactiveColor != null &&
        waitingColor != null;
  }

  @override
  int get hashCode {
    return hashValues(
      textStyle,
      iconThemeData,
      disabledColor,
      color,
      focusColor,
      hoverColor,
      waitingColor,
      inactiveColor,
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
        other.inactiveColor == inactiveColor &&
        other.waitingColor == waitingColor;
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
            color: textTheme.textMedium.toColor(),
          );

      final HSLColor color =
          buttonThemeData.color ?? colorScheme.shade[kInactiveColorIndex];

      final HSLColor hoverColor =
          buttonThemeData.hoverColor ?? colorScheme.shade[kHoverColorIndex];

      final HSLColor waitingColor =
          buttonThemeData.waitingColor ?? colorScheme.background[8];

      final HSLColor disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;
      final HSLColor focusColor = buttonThemeData.focusColor ?? waitingColor;

      final HSLColor inactiveColor =
          buttonThemeData.inactiveColor ?? colorScheme.background;

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: _kIconSize, color: color.toColor());

      buttonThemeData = buttonThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        disabledColor: disabledColor,
        color: color,
        focusColor: focusColor,
        hoverColor: hoverColor,
        waitingColor: waitingColor,
        inactiveColor: inactiveColor,
      );
    }

    assert(buttonThemeData.isConcrete);

    return buttonThemeData;
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
