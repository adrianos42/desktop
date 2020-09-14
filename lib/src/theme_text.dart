import 'theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import "theme_color.dart";

class _TextColors {
  static const Color lightTextLow = Color(0xFF606060);
  static const Color lightTextMedium = Color(0xFF303030);
  static const Color lightTextHigh = Color(0xFF000000);
  static const Color lightForeground = Color(0xFF000000);

  static const Color darkTextLow = Color(0xFF808080);
  static const Color darkTextMedium = Color(0xFFB2B2B2);
  static const Color darkTextHigh = Color(0xFFE5E5E5);
  static const Color darkForeground = Color(0xFFFFFFFF);
}

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
    @required this.hearder,
    @required this.subheader,
    @required this.title,
    @required this.subtitle,
    @required this.body1,
    @required this.body2,
    @required this.caption,
    @required this.textHigh,
    @required this.textLow,
    @required this.textMedium,
    @required this.colorScheme,
    @required this.textForeground,
  })  : assert(body1 != null),
        assert(body2 != null),
        assert(caption != null),
        assert(hearder != null),
        assert(subheader != null),
        assert(subtitle != null),
        assert(title != null),
        assert(textHigh != null),
        assert(textMedium != null),
        assert(colorScheme != null),
        assert(textForeground != null),
        assert(textLow != null);

  factory TextTheme(Brightness brightness, ColorScheme colorScheme) {
    TextTheme result;

    switch (brightness) {
      case Brightness.dark:
        result = TextTheme._raw(
          body1: _TextThemes.body1.apply(color: _TextColors.darkTextHigh),
          body2: _TextThemes.body2.apply(color: _TextColors.darkTextHigh),
          caption: _TextThemes.caption.apply(color: _TextColors.darkTextHigh),
          hearder: _TextThemes.header.apply(color: _TextColors.darkTextHigh),
          subheader:
              _TextThemes.subheader.apply(color: _TextColors.darkTextHigh),
          subtitle: _TextThemes.subtitle.apply(color: _TextColors.darkTextHigh),
          title: _TextThemes.title.apply(color: _TextColors.darkTextHigh),
          textLow: _TextColors.darkTextLow,
          textMedium: _TextColors.darkTextMedium,
          textHigh: _TextColors.darkTextHigh,
          textForeground: _TextColors.darkForeground,
          colorScheme: colorScheme,
        );
        break;

      case Brightness.light:
        result = TextTheme._raw(
          body1: _TextThemes.body1.apply(color: _TextColors.lightTextHigh),
          body2: _TextThemes.body2.apply(color: _TextColors.lightTextHigh),
          caption: _TextThemes.caption.apply(color: _TextColors.lightTextHigh),
          hearder: _TextThemes.header.apply(color: _TextColors.lightTextHigh),
          subheader:
              _TextThemes.subheader.apply(color: _TextColors.lightTextHigh),
          subtitle:
              _TextThemes.subtitle.apply(color: _TextColors.lightTextHigh),
          title: _TextThemes.title.apply(color: _TextColors.lightTextHigh),
          textLow: _TextColors.lightTextLow,
          textMedium: _TextColors.lightTextMedium,
          textHigh: _TextColors.lightTextHigh,
          textForeground: _TextColors.lightForeground,
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

  final Color textHigh;

  final Color textMedium;

  final Color textLow;

  final ColorScheme colorScheme;

  // Foreground only Used for content text foreground
  final Color textForeground;

  Color foreground(Color background) {
    Color effectiveForeground;

    if (background == colorScheme.overlay1) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay2) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay3) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay4) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay5) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay6) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay7) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay8) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay9) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.overlay10) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.primary) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.primary2) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.primary3) {
      effectiveForeground = textHigh;
    } else if (background == colorScheme.background) {
      effectiveForeground = textMedium;
    }

    return effectiveForeground;
  }

  Color disabledForeground(Color background) {
    Color effectiveForeground;

    if (background == colorScheme.overlay1) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay2) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay3) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay4) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay5) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay6) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay7) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay8) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay9) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.overlay10) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.primary) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.primary2) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.primary3) {
      effectiveForeground = colorScheme.overlay6;
    } else if (background == colorScheme.background) {
      effectiveForeground = colorScheme.overlay6;
    }

    return effectiveForeground;
  }
}
