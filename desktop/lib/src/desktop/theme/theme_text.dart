import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';

export 'theme_data.dart' show ThemeData, Theme;

const _kFontFamily = 'IBM Plex Sans';
const _kFontFamilyMono = 'IBM Plex Mono';
const _kFontPackage = 'desktop';

class _TextThemes {
  static const TextStyle header = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.w300,
    fontSize: 44.0,
  );

  static const TextStyle subheader = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.w300,
    fontSize: 34.0,
  );

  static const TextStyle title = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.w400,
    fontSize: 24.0,
  );

  static const TextStyle subtitle = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.normal,
    fontSize: 20.0,
  );

  static const TextStyle body1 = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );

  static const TextStyle body2 = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );

  static const TextStyle caption = TextStyle(
    inherit: false,
    fontFamily: _kFontFamily,
    package: _kFontPackage,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );

  static const TextStyle monospace = TextStyle(
    inherit: false,
    fontFamily: _kFontFamilyMono,
    package: _kFontPackage,
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
    required this.textLow,
    required this.textMedium,
    required this.textHigh,
    required this.textError,
    required this.textPrimaryHigh,
    required this.textPrimaryLow,
    required this.textDisabled,
    required this.colorScheme,
    required this.monospace,
  });

  factory TextTheme.withColorScheme(ColorScheme colorScheme) {
    TextTheme result;

    switch (colorScheme.brightness) {
      case Brightness.dark:
        final textLow = colorScheme.shade[50];
        final textMedium = colorScheme.shade[70];
        final textHigh = colorScheme.shade[90];

        result = TextTheme._raw(
          header: _TextThemes.header.apply(color: textHigh),
          subheader: _TextThemes.subheader.apply(color: textHigh),
          subtitle: _TextThemes.subtitle.apply(color: textHigh),
          title: _TextThemes.title.apply(color: textHigh),
          monospace: _TextThemes.monospace.apply(color: textHigh),
          body1: _TextThemes.body1.apply(color: textHigh),
          body2: _TextThemes.body2.apply(color: textHigh),
          caption: _TextThemes.caption.apply(color: textHigh),
          textError: colorScheme.error,
          textPrimaryHigh: colorScheme.primary[60],
          textPrimaryLow: colorScheme.primary[40],
          textLow: textLow,
          textMedium: textMedium,
          textHigh: textHigh,
          textDisabled: colorScheme.disabled,
          colorScheme: colorScheme,
        );
        break;

      case Brightness.light:
        final textLow = colorScheme.shade[40];
        final textMedium = colorScheme.shade[70];
        final textHigh = colorScheme.shade[100];

        result = TextTheme._raw(
          header: _TextThemes.header.apply(color: textHigh),
          subheader: _TextThemes.subheader.apply(color: textHigh),
          subtitle: _TextThemes.subtitle.apply(color: textHigh),
          title: _TextThemes.title.apply(color: textHigh),
          monospace: _TextThemes.monospace.apply(color: textHigh),
          body1: _TextThemes.body1.apply(color: textHigh),
          body2: _TextThemes.body2.apply(color: textHigh),
          caption: _TextThemes.caption.apply(color: textHigh),
          textError: colorScheme.error,
          textPrimaryHigh: colorScheme.primary[60],
          textPrimaryLow: colorScheme.primary[40],
          textLow: textLow,
          textMedium: textMedium,
          textHigh: textHigh,
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

  final Color textHigh;

  final Color textMedium;

  final Color textLow;

  final Color textError;

  final Color textDisabled;

  final Color textPrimaryHigh;

  final Color textPrimaryLow;

  final ColorScheme colorScheme;
}
