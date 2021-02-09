import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'theme_color.dart';
import 'theme_text.dart';
import 'theme_nav.dart';
import 'theme_button.dart';
import 'theme_hyperlink_button.dart';
import 'theme_dialog.dart';

class ThemeData {
  factory ThemeData({
    required Brightness brightness,
    HSLColor primaryColor = kDefaultPrimary,
  }) {
    final colorScheme = ColorScheme(brightness, primaryColor);

    return ThemeData._raw(
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: TextTheme(brightness, colorScheme),
      navTheme: const NavThemeData(),
      buttonTheme: const ButtonThemeData(),
      dialogTheme: const DialogThemeData(),
      hyperlinkButtonTheme: const HyperlinkButtonThemeData(),
    );
  }

  const ThemeData._raw({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    required this.navTheme,
    required this.buttonTheme,
    required this.dialogTheme,
    required this.hyperlinkButtonTheme,
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

  final DialogThemeData dialogTheme;

  final HyperlinkButtonThemeData hyperlinkButtonTheme;

  ThemeData get invertedTheme {
    final Brightness inverseBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;

    final invertedColorScheme =colorScheme.withBrightness(inverseBrightness);

    return ThemeData._raw(
      brightness: inverseBrightness,
      colorScheme: invertedColorScheme,
      navTheme: const NavThemeData(),
      textTheme: TextTheme(inverseBrightness, invertedColorScheme),
      buttonTheme: const ButtonThemeData(),
      dialogTheme: const DialogThemeData(),
      hyperlinkButtonTheme: const HyperlinkButtonThemeData(),
    );
  }
}
