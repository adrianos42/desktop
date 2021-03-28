import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';

class RadioButtonThemeData {
  const RadioButtonThemeData({
    this.disabledColor,
    this.activeColor,
    this.foreground,
    this.activeHoverColor,
    this.inactiveColor,
    this.inactiveHoverColor,
  });

  final HSLColor? disabledColor;

  final HSLColor? activeColor;

  final HSLColor? activeHoverColor;

  final HSLColor? inactiveColor;

  final HSLColor? inactiveHoverColor;

  final HSLColor? foreground;

  RadioButtonThemeData copyWith({
    HSLColor? disabledColor,
    HSLColor? activeColor,
    HSLColor? foreground,
    HSLColor? activeHoverColor,
    HSLColor? inactiveColor,
    HSLColor? inactiveHoverColor,
  }) {
    return RadioButtonThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      foreground: foreground ?? this.foreground,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      inactiveHoverColor: inactiveHoverColor ?? this.inactiveHoverColor,
    );
  }

  RadioButtonThemeData merge(RadioButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(
      disabledColor: other.disabledColor,
      activeColor: other.activeColor,
      foreground: other.foreground,
      activeHoverColor: other.activeHoverColor,
      inactiveColor: other.inactiveColor,
      inactiveHoverColor: inactiveHoverColor,
    );
  }

  bool get isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        activeHoverColor != null &&
        inactiveHoverColor != null &&
        inactiveColor != null &&
        foreground != null;
  }

  @override
  int get hashCode {
    return hashValues(
      disabledColor,
      activeColor,
      foreground,
      activeHoverColor,
      inactiveColor,
      inactiveHoverColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is RadioButtonThemeData &&
        other.disabledColor == disabledColor &&
        other.activeColor == activeColor &&
        other.activeHoverColor == activeHoverColor &&
        other.inactiveHoverColor == inactiveHoverColor &&
        other.inactiveColor == inactiveColor &&
        other.foreground == foreground;
  }
}

// Examples can assume:
class RadioButtonTheme extends InheritedTheme {
  const RadioButtonTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final RadioButtonThemeData data;

  static Widget merge({
    Key? key,
    required RadioButtonThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => RadioButtonTheme(
        key: key,
        data: RadioButtonTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static RadioButtonThemeData of(BuildContext context) {
    final RadioButtonTheme? radioButtonTheme =
        context.dependOnInheritedWidgetOfExactType<RadioButtonTheme>();
    RadioButtonThemeData? radioButtonThemeData = radioButtonTheme?.data;

    if (radioButtonThemeData == null || !radioButtonThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      radioButtonThemeData ??= themeData.radioButtonTheme;

      final ColorScheme colorScheme = themeData.colorScheme;

      final HSLColor foreground =
          radioButtonThemeData.foreground ?? colorScheme.shade;

      final HSLColor activeHoverColor =
          radioButtonThemeData.activeHoverColor ?? colorScheme.primary;

      final HSLColor activeColor =
          radioButtonThemeData.activeColor ?? colorScheme.primary2;

      final HSLColor inactiveHoverColor =
          radioButtonThemeData.activeHoverColor ?? colorScheme.shade;

      final HSLColor inactiveColor =
          radioButtonThemeData.activeColor ?? colorScheme.shade2;

      final HSLColor disabledColor =
          radioButtonThemeData.disabledColor ?? colorScheme.disabled;

      radioButtonThemeData = radioButtonThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        foreground: foreground,
        activeHoverColor: activeHoverColor,
        inactiveHoverColor: inactiveHoverColor,
        inactiveColor: inactiveColor,
      );
    }

    assert(radioButtonThemeData.isConcrete);

    return radioButtonThemeData;
  }

  @override
  bool updateShouldNotify(RadioButtonTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final RadioButtonTheme? radioButtonTheme =
        context.findAncestorWidgetOfExactType<RadioButtonTheme>();
    return identical(this, radioButtonTheme)
        ? child
        : RadioButtonTheme(data: data, child: child);
  }
}
