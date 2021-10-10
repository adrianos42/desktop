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
import 'list_table.dart';
import 'nav.dart';
import 'radio.dart';
import 'scrollbar.dart';
import 'slider.dart';
import 'tab.dart';
import 'theme_text.dart';
import 'toggle_switch.dart';
import 'tree.dart';

@immutable
class Theme extends StatefulWidget {
  const Theme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final ThemeData data;

  final Widget child;

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

  static ThemeData invertedThemeOf(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>()!;

    return inheritedTheme.theme.data.invertedTheme;
  }

  static void updateThemeData(BuildContext context, ThemeData themeData) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>()!;

    inheritedTheme.theme.updateThemeData(themeData);
  }

  @override
  _ThemeState createState() => _ThemeState();
}

class _ThemeState extends State<Theme> {
  ThemeData? _data;

  ThemeData get data => _data ?? widget.data;

  void updateThemeData(ThemeData themeData) {
    setState(() => _data = themeData);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: Builder(
        builder: (context) => DefaultTextStyle(
          style: Theme.of(context).textTheme.body1,
          child: widget.child,
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

  final _ThemeState theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme)
        ? child
        : Theme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => true;
}

/// The data for the [Theme] for desktop apps.
@immutable
class ThemeData {
  /// Creates a [ThemeData].
  factory ThemeData({
    required Brightness brightness,
    PrimaryColor? primaryColor,
    BackgroundColor? backgroundColor,
  }) {
    final colorScheme = ColorScheme(
      brightness,
      primary: primaryColor,
      backgroundColor: backgroundColor,
    );

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
      listTableTheme: const ListTableThemeData(),
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
    required this.listTableTheme,
  });

  factory ThemeData.light([PrimaryColor? primaryColor]) =>
      ThemeData(brightness: Brightness.light, primaryColor: primaryColor);

  factory ThemeData.dark([PrimaryColor? primaryColor]) =>
      ThemeData(brightness: Brightness.dark, primaryColor: primaryColor);

  ThemeData withBrightness(Brightness brightness) {
    final colorScheme = this.colorScheme.withBrightness(brightness);
    final textTheme = TextTheme.withColorScheme(colorScheme);

    return ThemeData._raw(
        brightness: brightness,
        colorScheme: colorScheme,
        textTheme: textTheme,
        navTheme: navTheme,
        buttonTheme: buttonTheme,
        dropDownButtonTheme: dropDownButtonTheme,
        dialogTheme: dialogTheme,
        contextMenuTheme: contextMenuTheme,
        hyperlinkButtonTheme: hyperlinkButtonTheme,
        radioButtonTheme: radioButtonTheme,
        checkboxTheme: checkboxTheme,
        sliderTheme: sliderTheme,
        toggleSwitchTheme: toggleSwitchTheme,
        scrollbarTheme: scrollbarTheme,
        tabTheme: tabTheme,
        treeTheme: treeTheme,
        listTableTheme: listTableTheme);
  }

  ThemeData copyWith({
    Brightness? brightness,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    NavThemeData? navTheme,
    TabThemeData? tabTheme,
    TreeThemeData? treeTheme,
    ButtonThemeData? buttonTheme,
    DropDownButtonThemeData? dropDownButtonTheme,
    DialogThemeData? dialogTheme,
    ContextMenuThemeData? contextMenuTheme,
    HyperlinkButtonThemeData? hyperlinkButtonTheme,
    RadioButtonThemeData? radioButtonTheme,
    CheckboxThemeData? checkboxTheme,
    ToggleSwitchThemeData? toggleSwitchTheme,
    SliderThemeData? sliderTheme,
    ScrollbarThemeData? scrollbarTheme,
    ListTableThemeData? listTableTheme,
  }) {
    final newColorScheme =
        colorScheme?.withBrightness(brightness ?? this.brightness) ??
            this.colorScheme.withBrightness(brightness ?? this.brightness);
    return ThemeData._raw(
      brightness: brightness ?? this.brightness,
      colorScheme: newColorScheme,
      textTheme: textTheme ?? TextTheme.withColorScheme(newColorScheme),
      navTheme: navTheme ?? this.navTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      dropDownButtonTheme: dropDownButtonTheme ?? this.dropDownButtonTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      contextMenuTheme: contextMenuTheme ?? this.contextMenuTheme,
      hyperlinkButtonTheme: hyperlinkButtonTheme ?? this.hyperlinkButtonTheme,
      radioButtonTheme: radioButtonTheme ?? this.radioButtonTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      sliderTheme: sliderTheme ?? this.sliderTheme,
      toggleSwitchTheme: toggleSwitchTheme ?? this.toggleSwitchTheme,
      scrollbarTheme: scrollbarTheme ?? this.scrollbarTheme,
      tabTheme: tabTheme ?? this.tabTheme,
      treeTheme: treeTheme ?? this.treeTheme,
      listTableTheme: listTableTheme ?? this.listTableTheme,
    );
  }

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

  final ListTableThemeData listTableTheme;

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
      listTableTheme: listTableTheme,
    );
  }
}
