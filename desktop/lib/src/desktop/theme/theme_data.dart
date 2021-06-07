import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'checkbox.dart';
import 'color_scheme.dart';
import 'context_menu.dart';
import 'dialog.dart';
import 'drop_down.dart';
import 'hyperlink.dart';
import 'nav.dart';
import 'radio.dart';
import 'scrollbar.dart';
import 'slider.dart';
import 'tab.dart';
import 'theme_text.dart';
import 'toggle_switch.dart';
import 'tree.dart';

@immutable
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
  Widget build(BuildContext context) {
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

@immutable
class ThemeData {
  /// Creates a [ThemeData].
  factory ThemeData({
    required Brightness brightness,
    PrimaryColor? primaryColor,
    BackgroundColor? backgroundColor,
  }) {
    final colorScheme = ColorScheme(brightness, primaryColor, backgroundColor);

    return ThemeData._raw(
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: TextTheme.withColorScheme(colorScheme),
      navTheme: const NavThemeData(),
      buttonTheme: const ButtonThemeData(),
      dropDownButtonTheme: const DropDownButtonThemeData(),
      dialogTheme: const DialogThemeData(),
      contextMenuTheme: const ContextMenuThemeData(),
      hyperlinkButtonTheme: const HyperlinkButtonThemeData(),
      radioButtonTheme: const RadioButtonThemeData(),
      checkboxTheme: const CheckboxThemeData(),
      toggleSwitchTheme: const ToggleSwitchThemeData(),
      sliderTheme: const SliderThemeData(),
      scrollbarTheme: const ScrollbarThemeData(),
      tabTheme: const TabThemeData(),
      treeTheme: const TreeThemeData(),
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
    required this.contextMenuTheme,
    required this.hyperlinkButtonTheme,
    required this.radioButtonTheme,
    required this.checkboxTheme,
    required this.sliderTheme,
    required this.toggleSwitchTheme,
    required this.scrollbarTheme,
    required this.tabTheme,
    required this.treeTheme,
  });

  factory ThemeData.light([PrimaryColor? primaryColor]) =>
      ThemeData(brightness: Brightness.light, primaryColor: primaryColor);

  factory ThemeData.dark([PrimaryColor? primaryColor]) =>
      ThemeData(brightness: Brightness.dark, primaryColor: primaryColor);

  factory ThemeData.fallback() => ThemeData(brightness: Brightness.dark);

  final Brightness brightness;

  final ColorScheme colorScheme;

  final TextTheme textTheme;

  final NavThemeData navTheme;

  final TabThemeData tabTheme;

  final TreeThemeData treeTheme;

  final ButtonThemeData buttonTheme;

  final DropDownButtonThemeData dropDownButtonTheme;

  final DialogThemeData dialogTheme;

  final ContextMenuThemeData contextMenuTheme;

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
      navTheme: navTheme,
      textTheme: TextTheme.withColorScheme(invertedColorScheme),
      buttonTheme: buttonTheme,
      dropDownButtonTheme: dropDownButtonTheme,
      dialogTheme: dialogTheme,
      contextMenuTheme: contextMenuTheme,
      hyperlinkButtonTheme: hyperlinkButtonTheme,
      radioButtonTheme: radioButtonTheme,
      checkboxTheme: checkboxTheme,
      toggleSwitchTheme: toggleSwitchTheme,
      sliderTheme: sliderTheme,
      scrollbarTheme: scrollbarTheme,
      tabTheme: tabTheme,
      treeTheme: treeTheme,
    );
  }
}
