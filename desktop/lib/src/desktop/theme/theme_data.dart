import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'color_scheme.dart';
import 'theme_text.dart';
import 'nav.dart';
import 'button.dart';
import 'button_hyperlink.dart';
import 'dialog.dart';
import 'button_drop_down.dart';
import 'checkbox.dart';
import 'toggle_switch.dart';
import 'slider.dart';
import 'button_radio.dart';
import 'scrollbar.dart';

class Theme extends StatelessWidget {
  const Theme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final ThemeData data;

  static ThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme.data ?? ThemeData.dark();
  }

  static Brightness brightnessOf(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>()!;

    return inheritedTheme.theme.data.brightness;
  }

  final Widget child;

  static ThemeData invertedThemeOf(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>()!;

    return inheritedTheme.theme.data.invertedTheme;
  }

  @override
  build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: Builder(
        builder: (context) => DefaultTextStyle(
          style: of(context).textTheme.body1,
          child: child,
        ),
      ),
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final Theme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme)
        ? child
        : Theme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}

class ThemeData {
  factory ThemeData({
    required Brightness brightness,
    HSLColor primaryColor = kDefaultPrimary,
  }) {
    final colorScheme = ColorScheme(brightness, primaryColor);

    return ThemeData._raw(
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: TextTheme(colorScheme),
      navTheme: const NavThemeData(),
      buttonTheme: const ButtonThemeData(),
      dropDownButtonTheme: const DropDownButtonThemeData(),
      dialogTheme: const DialogThemeData(),
      hyperlinkButtonTheme: const HyperlinkButtonThemeData(),
      radioButtonTheme: const RadioButtonThemeData(),
      checkboxTheme: const CheckboxThemeData(),
      toggleSwitchTheme: const ToggleSwitchThemeData(),
      sliderTheme: const SliderThemeData(),
      scrollbarTheme: const ScrollbarThemeData(),
    );
  }

  const ThemeData._raw({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    required this.navTheme,
    required this.buttonTheme,
    required this.dropDownButtonTheme,
    required this.dialogTheme,
    required this.hyperlinkButtonTheme,
    required this.radioButtonTheme,
    required this.checkboxTheme,
    required this.sliderTheme,
    required this.toggleSwitchTheme,
    required this.scrollbarTheme,
  });

  factory ThemeData.light([HSLColor primaryColor = kDefaultPrimary]) =>
      ThemeData(brightness: Brightness.light, primaryColor: primaryColor);

  factory ThemeData.dark([HSLColor primaryColor = kDefaultPrimary]) =>
      ThemeData(brightness: Brightness.dark, primaryColor: primaryColor);

  factory ThemeData.fallback() => ThemeData(brightness: Brightness.dark);

  final Brightness brightness;

  final ColorScheme colorScheme;

  final TextTheme textTheme;

  final NavThemeData navTheme;

  final ButtonThemeData buttonTheme;

  final DropDownButtonThemeData dropDownButtonTheme;

  final DialogThemeData dialogTheme;

  final HyperlinkButtonThemeData hyperlinkButtonTheme;

  final RadioButtonThemeData radioButtonTheme;

  final CheckboxThemeData checkboxTheme;

  final ToggleSwitchThemeData toggleSwitchTheme;

  final SliderThemeData sliderTheme;

  final ScrollbarThemeData scrollbarTheme;

  ThemeData get invertedTheme {
    final Brightness inverseBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;

    final invertedColorScheme = colorScheme.withBrightness(inverseBrightness);

    return ThemeData._raw(
      brightness: inverseBrightness,
      colorScheme: invertedColorScheme,
      navTheme: const NavThemeData(),
      textTheme: TextTheme(invertedColorScheme),
      buttonTheme: const ButtonThemeData(),
      dropDownButtonTheme: const DropDownButtonThemeData(),
      dialogTheme: const DialogThemeData(),
      hyperlinkButtonTheme: const HyperlinkButtonThemeData(),
      radioButtonTheme: const RadioButtonThemeData(),
      checkboxTheme: const CheckboxThemeData(),
      toggleSwitchTheme: const ToggleSwitchThemeData(),
      sliderTheme: const SliderThemeData(),
      scrollbarTheme: const ScrollbarThemeData(),
    );
  }
}
