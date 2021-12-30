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
    this.inactiveBackgroundColor,
  });

  final IconThemeData? iconThemeData;

  final TextStyle? textStyle;

  final Color? disabledColor;

  final Color? color;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? waitingColor;

  final Color? backgroundColor;

  final Color? inactiveBackgroundColor;

  DropDownButtonThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    Color? disabledColor,
    Color? color,
    Color? focusColor,
    Color? hoverColor,
    Color? waitingColor,
    Color? backgroundColor,
    Color? inactiveBackgroundColor,
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
      inactiveBackgroundColor: inactiveBackgroundColor ?? this.inactiveBackgroundColor,
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
      backgroundColor: other.backgroundColor,
      inactiveBackgroundColor: other.inactiveBackgroundColor,
    );
  }

  bool get isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        disabledColor != null &&
        color != null &&
        focusColor != null &&
        hoverColor != null &&
        inactiveBackgroundColor != null &&
        backgroundColor != null &&
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
      backgroundColor,
      inactiveBackgroundColor,
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
        other.inactiveBackgroundColor == inactiveBackgroundColor &&
        other.backgroundColor == backgroundColor &&
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
            color: textTheme.textMedium,
          );

      final Color color =
          buttonThemeData.color ?? colorScheme.shade[kInactiveColorIndex];

      final Color hoverColor =
          buttonThemeData.hoverColor ?? colorScheme.shade[kHoverColorIndex];

      final Color waitingColor =
          buttonThemeData.waitingColor ?? colorScheme.shade[30];

      final Color backgroundColor =
          buttonThemeData.backgroundColor ?? colorScheme.background[0];

      final Color disabledColor =
          buttonThemeData.disabledColor ?? colorScheme.disabled;
      final Color focusColor = buttonThemeData.focusColor ?? waitingColor;

      final Color inactiveBackgroundColor =
          buttonThemeData.inactiveBackgroundColor ?? colorScheme.background[0];

      final IconThemeData iconThemeData = buttonThemeData.iconThemeData ??
          IconThemeData(size: _kIconSize, color: hoverColor);

      buttonThemeData = buttonThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        disabledColor: disabledColor,
        color: color,
        focusColor: focusColor,
        hoverColor: hoverColor,
        waitingColor: waitingColor,
        backgroundColor: backgroundColor,
        inactiveBackgroundColor: inactiveBackgroundColor,
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
