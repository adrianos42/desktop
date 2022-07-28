import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';

@immutable
class RadioButtonThemeData {
  const RadioButtonThemeData({
    this.disabledColor,
    this.activeColor,
    this.foreground,
    this.activeHoverColor,
    this.inactiveColor,
    this.inactiveHoverColor,
  });

  final Color? disabledColor;

  final Color? activeColor;

  final Color? activeHoverColor;

  final Color? inactiveColor;

  final Color? inactiveHoverColor;

  final Color? foreground;

  RadioButtonThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? foreground,
    Color? activeHoverColor,
    Color? inactiveColor,
    Color? inactiveHoverColor,
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
    if (other == null) {
      return this;
    }
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
    return Object.hash(
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
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RadioButtonThemeData &&
        other.disabledColor == disabledColor &&
        other.activeColor == activeColor &&
        other.activeHoverColor == activeHoverColor &&
        other.inactiveHoverColor == inactiveHoverColor &&
        other.inactiveColor == inactiveColor &&
        other.foreground == foreground;
  }
}

@immutable
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
      final ColorScheme colorScheme = themeData.colorScheme;
      final TextTheme textTheme = themeData.textTheme;

      radioButtonThemeData ??= themeData.radioButtonTheme;

      final Color foreground =
          radioButtonThemeData.foreground ?? colorScheme.shade[100];

      final Color activeHoverColor =
          radioButtonThemeData.activeHoverColor ?? colorScheme.primary[60];

      final Color activeColor =
          radioButtonThemeData.activeColor ?? colorScheme.primary[60];

      final Color inactiveHoverColor =
          radioButtonThemeData.inactiveHoverColor ?? colorScheme.shade[100];

      final Color inactiveColor =
          radioButtonThemeData.inactiveColor ?? colorScheme.shade[50];

      final Color disabledColor =
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
