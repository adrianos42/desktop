import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' show Brightness;
import 'color_scheme.dart';

class _TextThemes {
  static const TextStyle header = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w300,
    fontSize: 44.0,
    //height: 1.2,
  );

  static const TextStyle subheader = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w300,
    fontSize: 34.0,
    //height: 1.2,
  );

  static const TextStyle title = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w400,
    fontSize: 24.0,
    //height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    //height: 1.2,
  );

  static const TextStyle body1 = TextStyle(
    inherit: false,
    //fontFamily: 'IBM Plex Sans',
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    //height: 1.2,
  );

  static const TextStyle body2 = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    //height: 1.2,
  );

  static const TextStyle caption = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Sans',
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    //height: 1.2,
  );

  static const TextStyle monospace = TextStyle(
    inherit: false,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w400,
    fontSize: 13.0,
  );
}

@immutable
class TextTheme {
  const TextTheme._raw({
    required this.header,
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
    required this.textDisabled,
    required this.monospace,
  });

  factory TextTheme(ColorScheme colorScheme) {
    TextTheme result;

    switch (colorScheme.brightness) {
      case Brightness.dark:
        final foreground = colorScheme.shade.toColor();
        result = TextTheme._raw(
          header: _TextThemes.header.apply(color: foreground),
          subheader: _TextThemes.subheader.apply(color: foreground),
          subtitle: _TextThemes.subtitle.apply(color: foreground),
          title: _TextThemes.title.apply(color: foreground),
          monospace: _TextThemes.monospace.apply(color: foreground),
          body1: _TextThemes.body1.apply(color: foreground),
          body2: _TextThemes.body2.apply(color: foreground),
          caption: _TextThemes.caption.apply(color: foreground),
          textLow: colorScheme.shade4,
          textMedium: colorScheme.shade2,
          textHigh: colorScheme.shade,
          textDisabled: colorScheme.disabled,
          colorScheme: colorScheme,
        );
        break;

      case Brightness.light:
        final foreground = colorScheme.shade.toColor();
        result = TextTheme._raw(
          header: _TextThemes.header.apply(color: foreground),
          subheader: _TextThemes.subheader.apply(color: foreground),
          subtitle: _TextThemes.subtitle.apply(color: foreground),
          title: _TextThemes.title.apply(color: foreground),
          monospace: _TextThemes.monospace.apply(color: foreground),
          body1: _TextThemes.body1.apply(color: foreground),
          body2: _TextThemes.body2.apply(color: foreground),
          caption: _TextThemes.caption.apply(color: foreground),
          textLow: colorScheme.shade4,
          textMedium: colorScheme.shade2,
          textHigh: colorScheme.shade,
          textDisabled: colorScheme.disabled,
          colorScheme: colorScheme,
        );
        break;
    }

    return result;
  }

  final TextStyle header;

  final TextStyle subheader;

  final TextStyle title;

  final TextStyle subtitle;

  final TextStyle body1;

  final TextStyle body2;

  final TextStyle caption;

  final TextStyle monospace;

  final HSLColor textHigh;

  final HSLColor textMedium;

  final HSLColor textLow;

  final HSLColor textDisabled;

  final ColorScheme colorScheme;

  HSLColor effectiveForeground(HSLColor background) {
    // HSLColor effectiveForeground = background;

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
    // }Q

    return textHigh;
  }

  HSLColor effectiveDisabledForeground(HSLColor background) {
    // HSLColor effectiveForeground = background;

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

    return textDisabled;
  }
}
