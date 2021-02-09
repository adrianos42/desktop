import 'theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import "theme_color.dart";

const HSLColor _kLightTextLow = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.6);
const HSLColor _kLightTextMedium = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.4);
const HSLColor _kLightTextHigh = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.0);
const HSLColor _kLightForeground = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.0);

const HSLColor _kDarkTextLow = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.5);
const HSLColor _kDarkTextMedium = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.7);
const HSLColor _kDarkTextHigh = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.9);
const HSLColor _kDarkForeground = HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0);

class _TextThemes {
  static const TextStyle header = TextStyle(
    inherit: false,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w400,
    fontSize: 44.0,
    height: 1.2,
  );

  static const TextStyle subheader = TextStyle(
    inherit: false,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w400,
    fontSize: 34.0,
    height: 1.2,
  );

  static const TextStyle title = TextStyle(
    inherit: false,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w400,
    fontSize: 24.0,
    height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    inherit: false,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    height: 1.2,
  );

  static const TextStyle body1 = TextStyle(
    inherit: false,
    //fontFamily: 'IBM Plex Sans',
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    height: 1.4,
  );

  static const TextStyle body2 = TextStyle(
    inherit: false,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    inherit: false,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    height: 1.4,
  );

  static const TextStyle monospace = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w400,
    fontSize: 13.0,
    height: 1.0,
  );
}

@immutable
class TextTheme {
  const TextTheme._raw({
    required this.hearder,
    required this.subheader,
    required this.title,
    required this.subtitle,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.textHigh,
    required this.textLow,
    required this.textMedium,
    required this.colorScheme,
    required this.textForeground,
  });

  factory TextTheme(Brightness brightness, ColorScheme colorScheme) {
    TextTheme result;

    switch (brightness) {
      case Brightness.dark:
        result = TextTheme._raw(
          body1: _TextThemes.body1.apply(color: _kDarkTextHigh.toColor()),
          body2: _TextThemes.body2.apply(color: _kDarkTextHigh.toColor()),
          caption: _TextThemes.caption.apply(color: _kDarkTextHigh.toColor()),
          hearder: _TextThemes.header.apply(color: _kDarkTextHigh.toColor()),
          subheader:
              _TextThemes.subheader.apply(color: _kDarkTextHigh.toColor()),
          subtitle: _TextThemes.subtitle.apply(color: _kDarkTextHigh.toColor()),
          title: _TextThemes.title.apply(color: _kDarkTextHigh.toColor()),
          textLow: _kDarkTextLow,
          textMedium: _kDarkTextMedium,
          textHigh: _kDarkTextHigh,
          textForeground: _kDarkForeground,
          colorScheme: colorScheme,
        );
        break;

      case Brightness.light:
        result = TextTheme._raw(
          body1: _TextThemes.body1.apply(color: _kLightTextHigh.toColor()),
          body2: _TextThemes.body2.apply(color: _kLightTextHigh.toColor()),
          caption: _TextThemes.caption.apply(color: _kLightTextHigh.toColor()),
          hearder: _TextThemes.header.apply(color: _kLightTextHigh.toColor()),
          subheader:
              _TextThemes.subheader.apply(color: _kLightTextHigh.toColor()),
          subtitle:
              _TextThemes.subtitle.apply(color: _kLightTextHigh.toColor()),
          title: _TextThemes.title.apply(color: _kLightTextHigh.toColor()),
          textLow: _kLightTextLow,
          textMedium: _kLightTextMedium,
          textHigh: _kLightTextHigh,
          textForeground: _kLightForeground,
          colorScheme: colorScheme,
        );
        break;
    }

    return result;
  }

  final TextStyle hearder;

  final TextStyle subheader;

  final TextStyle title;

  final TextStyle subtitle;

  final TextStyle body1;

  final TextStyle body2;

  final TextStyle caption;

  final HSLColor textHigh;

  final HSLColor textMedium;

  final HSLColor textLow;

  final ColorScheme colorScheme;

  // Foreground only Used for content text foreground
  final HSLColor textForeground;

  HSLColor foreground(HSLColor background) {
    HSLColor effectiveForeground = background;

    // if (background == colorScheme.overlay1) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay2) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay3) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay4) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay5) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay6) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay7) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay8) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay9) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.overlay10) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.primary) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.primary2) {
    //   effectiveForeground = textHigh;
    // } else if (background == colorScheme.primary3) {
    //   effectiveForeground = textHigh;
    // } else {
    //   effectiveForeground = textMedium;
    // }

    return effectiveForeground;
  }

  HSLColor disabledForeground(HSLColor background) {
    HSLColor effectiveForeground = background;

    // if (background == colorScheme.overlay1) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay2) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay3) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay4) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay5) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay6) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay7) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay8) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay9) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.overlay10) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.primary) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.primary2) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else if (background == colorScheme.primary3) {
    //   effectiveForeground = colorScheme.overlay6;
    // } else {
    //   effectiveForeground = colorScheme.overlay6;
    // }

    return effectiveForeground;
  }
}
