import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'input/button.dart';
import 'input/checkbox.dart';
import 'color_scheme.dart';
import 'dialogs/context_menu.dart';
import 'dialogs/dialog.dart';
import 'input/drop_down.dart';
import 'input/hyperlink.dart';
import 'data/list_table.dart';
import 'navigation/nav.dart';
import 'input/radio.dart';
import 'scrolling/scrollbar.dart';
import 'input/slider.dart';
import 'navigation/tab.dart';
import 'theme_text.dart';
import 'input/toggle_switch.dart';
import 'navigation/tree.dart';

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
      dropDownTheme: const DropDownThemeData(),
      dialogTheme: const DialogThemeData(),
      contextMenuTheme: const ContextMenuThemeData(),
      hyperlinkTheme: const HyperlinkThemeData(),
      radioTheme: const RadioThemeData(),
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
    required this.dropDownTheme,
    required this.dialogTheme,
    required this.contextMenuTheme,
    required this.hyperlinkTheme,
    required this.radioTheme,
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
        dropDownTheme: dropDownTheme,
        dialogTheme: dialogTheme,
        contextMenuTheme: contextMenuTheme,
        hyperlinkTheme: hyperlinkTheme,
        radioTheme: radioTheme,
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
    DropDownThemeData? dropDownButtonTheme,
    DialogThemeData? dialogTheme,
    ContextMenuThemeData? contextMenuTheme,
    HyperlinkThemeData? hyperlinkButtonTheme,
    RadioThemeData? radioButtonTheme,
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
      dropDownTheme: dropDownButtonTheme ?? this.dropDownTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      contextMenuTheme: contextMenuTheme ?? this.contextMenuTheme,
      hyperlinkTheme: hyperlinkButtonTheme ?? this.hyperlinkTheme,
      radioTheme: radioButtonTheme ?? this.radioTheme,
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

  final DropDownThemeData dropDownTheme;

  final DialogThemeData dialogTheme;

  final ContextMenuThemeData contextMenuTheme;

  final HyperlinkThemeData hyperlinkTheme;

  final RadioThemeData radioTheme;

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
      dropDownTheme: dropDownTheme,
      dialogTheme: dialogTheme,
      contextMenuTheme: contextMenuTheme,
      hyperlinkTheme: hyperlinkTheme,
      radioTheme: radioTheme,
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
