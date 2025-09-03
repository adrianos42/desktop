import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'data/data.dart';
import 'dialogs/dialogs.dart';
import 'input/input.dart';
import 'navigation/navigation.dart';
import 'scrolling/scrollbar.dart';
import 'status/status.dart';
import 'theme_text.dart';

@immutable
class Theme extends StatefulWidget {
  const Theme({super.key, required this.data, required this.child});

  final ThemeData data;

  final Widget child;

  static ThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedTheme>();

    return inheritedTheme?.theme.data ?? ThemeData.fallback();
  }

  static void updateThemeData(BuildContext context, ThemeData themeData) {
    final _InheritedTheme inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedTheme>()!;

    inheritedTheme.theme.updateThemeData(themeData);
  }

  static Widget withBrightness(
    BuildContext context, {
    required Widget child,
    Brightness brightness = Brightness.dark,
  }) {
    return Theme(
      data: of(context).copyWith(brightness: brightness),
      child: child,
    );
  }

  @override
  State<Theme> createState() => _ThemeState();
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
          style: data.contentTextTheme.body1,
          child: widget.child,
        ),
      ),
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({required this.theme, required super.child});

  final _ThemeState theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme? ancestorTheme = context
        .findAncestorWidgetOfExactType<_InheritedTheme>();
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
    PrimaryColor? primaryColor,
    BackgroundColor? backgroundColor,
    ShadeColor? shadeColor,
  }) {
    final colorScheme = ColorScheme(
      primary: primaryColor,
      backgroundColor: backgroundColor,
      shade: shadeColor,
    );

    final contentColorScheme = ColorScheme(
      primary: colorScheme.primary,
      shade: colorScheme.shade.withBrightness(Brightness.dark),
      backgroundColor: colorScheme.background.withBrightness(Brightness.dark),
    );

    return ThemeData._raw(
      colorScheme: colorScheme,
      textTheme: TextTheme.withColorScheme(colorScheme),
      navTheme: const NavThemeData(),
      buttonTheme: const ButtonThemeData(),
      dropDownTheme: const DropDownThemeData(),
      dialogTheme: const DialogThemeData(),
      drawerTheme: const DrawerThemeData(),
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
      circularProgressIndicatorTheme:
          const CircularProgressIndicatorThemeData(),
      linearProgressIndicatorTheme: const LinearProgressIndicatorThemeData(),
      breadcrumbTheme: const BreadcrumbThemeData(),
      messageTheme: const MessageThemeData(),
      tooltipTheme: const TooltipThemeData(),
      floatingMenuBarTheme: const FloatingMenuBarThemeData(),
      brightness: Brightness.dark,
      contentColorScheme: contentColorScheme,
      contentTextTheme: TextTheme.withColorScheme(contentColorScheme),
    );
  }

  /// Creates a default theme.
  factory ThemeData.fallback() => ThemeData();

  const ThemeData._raw({
    required this.colorScheme,
    required this.textTheme,
    required this.navTheme,
    required this.buttonTheme,
    required this.dropDownTheme,
    required this.dialogTheme,
    required this.drawerTheme,
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
    required this.circularProgressIndicatorTheme,
    required this.linearProgressIndicatorTheme,
    required this.breadcrumbTheme,
    required this.messageTheme,
    required this.tooltipTheme,
    required this.floatingMenuBarTheme,
    this.brightness = Brightness.dark,
    required this.contentColorScheme,
    required this.contentTextTheme,
  });

  final Brightness brightness;

  final ColorScheme colorScheme;

  final TextTheme textTheme;

  final ColorScheme contentColorScheme;

  final TextTheme contentTextTheme;

  final NavThemeData navTheme;

  final TabThemeData tabTheme;

  final TreeThemeData treeTheme;

  final ButtonThemeData buttonTheme;

  final DropDownThemeData dropDownTheme;

  final DialogThemeData dialogTheme;

  final DrawerThemeData drawerTheme;

  final ContextMenuThemeData contextMenuTheme;

  final HyperlinkThemeData hyperlinkTheme;

  final RadioThemeData radioTheme;

  final CheckboxThemeData checkboxTheme;

  final ToggleSwitchThemeData toggleSwitchTheme;

  final SliderThemeData sliderTheme;

  final ScrollbarThemeData scrollbarTheme;

  final ListTableThemeData listTableTheme;

  final CircularProgressIndicatorThemeData circularProgressIndicatorTheme;

  final LinearProgressIndicatorThemeData linearProgressIndicatorTheme;

  final BreadcrumbThemeData breadcrumbTheme;

  final MessageThemeData messageTheme;

  final TooltipThemeData tooltipTheme;

  final FloatingMenuBarThemeData floatingMenuBarTheme;

  /// Creates a theme with selected fields.
  ThemeData copyWith({
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    NavThemeData? navTheme,
    TabThemeData? tabTheme,
    TreeThemeData? treeTheme,
    ButtonThemeData? buttonTheme,
    DropDownThemeData? dropDownTheme,
    DialogThemeData? dialogTheme,
    DrawerThemeData? drawerTheme,
    ContextMenuThemeData? contextMenuTheme,
    HyperlinkThemeData? hyperlinkTheme,
    RadioThemeData? radioTheme,
    CheckboxThemeData? checkboxTheme,
    ToggleSwitchThemeData? toggleSwitchTheme,
    SliderThemeData? sliderTheme,
    ScrollbarThemeData? scrollbarTheme,
    ListTableThemeData? listTableTheme,
    CircularProgressIndicatorThemeData? circularProgressIndicatorTheme,
    LinearProgressIndicatorThemeData? linearProgressIndicatorTheme,
    BreadcrumbThemeData? breadcrumbTheme,
    MessageThemeData? messageTheme,
    TooltipThemeData? tooltipTheme,
    FloatingMenuBarThemeData? floatingMenuBarTheme,
    Brightness? brightness,
  }) {
    final effectiveColorScheme = colorScheme ?? this.colorScheme;
    final effectiveBrightness = brightness ?? this.brightness;

    final contentColorScheme = ColorScheme(
      primary: effectiveColorScheme.primary,
      shade: effectiveColorScheme.shade.withBrightness(effectiveBrightness),
      backgroundColor: effectiveColorScheme.background.withBrightness(
        effectiveBrightness,
      ),
      disabledColor: effectiveBrightness == Brightness.light
          ? const Color(0xffbfbfbf)
          : null,
    );

    return ThemeData._raw(
      colorScheme: effectiveColorScheme,
      textTheme: textTheme ?? TextTheme.withColorScheme(effectiveColorScheme),
      navTheme: navTheme ?? this.navTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      dropDownTheme: dropDownTheme ?? this.dropDownTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      drawerTheme: drawerTheme ?? this.drawerTheme,
      contextMenuTheme: contextMenuTheme ?? this.contextMenuTheme,
      hyperlinkTheme: hyperlinkTheme ?? this.hyperlinkTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      sliderTheme: sliderTheme ?? this.sliderTheme,
      toggleSwitchTheme: toggleSwitchTheme ?? this.toggleSwitchTheme,
      scrollbarTheme: scrollbarTheme ?? this.scrollbarTheme,
      tabTheme: tabTheme ?? this.tabTheme,
      treeTheme: treeTheme ?? this.treeTheme,
      listTableTheme: listTableTheme ?? this.listTableTheme,
      circularProgressIndicatorTheme:
          circularProgressIndicatorTheme ?? this.circularProgressIndicatorTheme,
      linearProgressIndicatorTheme:
          linearProgressIndicatorTheme ?? this.linearProgressIndicatorTheme,
      breadcrumbTheme: breadcrumbTheme ?? this.breadcrumbTheme,
      messageTheme: messageTheme ?? this.messageTheme,
      tooltipTheme: tooltipTheme ?? this.tooltipTheme,
      floatingMenuBarTheme: floatingMenuBarTheme ?? this.floatingMenuBarTheme,
      brightness: effectiveBrightness,
      contentColorScheme: contentColorScheme,
      contentTextTheme: TextTheme.withColorScheme(
        contentColorScheme,
        effectiveBrightness,
      ),
    );
  }

  ThemeData get invertedTheme {
    final contentColorScheme = ColorScheme(
      primary: colorScheme.primary,
      shade: colorScheme.shade.withBrightness(Brightness.light),
      backgroundColor: colorScheme.background.withBrightness(Brightness.light),
      disabledColor: const Color(0xffbfbfbf),
    );

    return ThemeData._raw(
      colorScheme: contentColorScheme,
      navTheme: navTheme,
      textTheme: TextTheme.withColorScheme(
        contentColorScheme,
        Brightness.light,
      ),
      buttonTheme: buttonTheme,
      dropDownTheme: dropDownTheme,
      dialogTheme: dialogTheme,
      drawerTheme: drawerTheme,
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
      circularProgressIndicatorTheme: circularProgressIndicatorTheme,
      linearProgressIndicatorTheme: linearProgressIndicatorTheme,
      breadcrumbTheme: breadcrumbTheme,
      messageTheme: messageTheme,
      tooltipTheme: tooltipTheme,
      floatingMenuBarTheme: floatingMenuBarTheme,
      contentColorScheme: colorScheme,
      contentTextTheme: TextTheme.withColorScheme(
        contentColorScheme,
        Brightness.dark,
      ),
    );
  }

  @override
  int get hashCode {
    return Object.hash(
      colorScheme,
      textTheme,
      navTheme,
      buttonTheme,
      dropDownTheme,
      dialogTheme,
      contextMenuTheme,
      hyperlinkTheme,
      radioTheme,
      checkboxTheme,
      sliderTheme,
      toggleSwitchTheme,
      scrollbarTheme,
      tabTheme,
      treeTheme,
      listTableTheme,
      circularProgressIndicatorTheme,
      linearProgressIndicatorTheme,
      Object.hash(
        breadcrumbTheme,
        messageTheme,
        tooltipTheme,
        floatingMenuBarTheme,
        drawerTheme,
        brightness,
      ),
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
    return other is ThemeData &&
        other.colorScheme == colorScheme &&
        other.textTheme == textTheme &&
        other.navTheme == navTheme &&
        other.buttonTheme == buttonTheme &&
        other.dropDownTheme == dropDownTheme &&
        other.dialogTheme == dialogTheme &&
        other.drawerTheme == drawerTheme &&
        other.contextMenuTheme == contextMenuTheme &&
        other.hyperlinkTheme == hyperlinkTheme &&
        other.radioTheme == radioTheme &&
        other.checkboxTheme == checkboxTheme &&
        other.sliderTheme == sliderTheme &&
        other.toggleSwitchTheme == toggleSwitchTheme &&
        other.scrollbarTheme == scrollbarTheme &&
        other.tabTheme == tabTheme &&
        other.treeTheme == treeTheme &&
        other.listTableTheme == listTableTheme &&
        other.circularProgressIndicatorTheme ==
            circularProgressIndicatorTheme &&
        other.linearProgressIndicatorTheme == linearProgressIndicatorTheme &&
        other.breadcrumbTheme == breadcrumbTheme &&
        other.messageTheme == messageTheme &&
        other.tooltipTheme == tooltipTheme &&
        other.floatingMenuBarTheme == floatingMenuBarTheme;
  }
}
