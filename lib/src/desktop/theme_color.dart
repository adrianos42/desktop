import 'dart:ui' show Color, Brightness;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class _Colors {
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkOverlay1 = Color(0xFF080808);
  static const Color darkOverlay2 = Color(0xFF101010);
  static const Color darkOverlay3 = Color(0xFF181818);
  static const Color darkOverlay4 = Color(0xFF202020);
  static const Color darkOverlay5 = Color(0xFF282828);
  static const Color darkOverlay6 = Color(0xFF303030);
  static const Color darkOverlay7 = Color(0xFF383838);
  static const Color darkOverlay8 = Color(0xFF404040);
  static const Color darkOverlay9 = Color(0xFF484848);
  static const Color darkOverlay10 = Color(0xFF505050);

  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightOverlay1 = Color(0xFFE0E0E0);
  static const Color lightOverlay2 = Color(0xFFD0D0D0);
  static const Color lightOverlay3 = Color(0xFFC0C0C0);
  static const Color lightOverlay4 = Color(0xFFB0B0B0);
  static const Color lightOverlay5 = Color(0xFFA0A0A0);
  static const Color lightOverlay6 = Color(0xFF909090);
  static const Color lightOverlay7 = Color(0xFF808080);
  static const Color lightOverlay8 = Color(0xFF707070);
  static const Color lightOverlay9 = Color(0xFF606060);
  static const Color lightOverlay10 = Color(0xFF505050);

  static const Color darkPrimary = Color(0xFF1C86EE);
  static const Color darkPrimary2 = Color(0xFF1874CD);
  static const Color darkPrimary3 = Color(0xFF104E8B);

  static const Color lightPrimary = Color(0xFF1C86EE);
  static const Color lightPrimary2 = Color(0xFF1874CD);
  static const Color lightPrimary3 = Color(0xFF104E8B);
}

@immutable
class ColorScheme {
  const ColorScheme._raw({
    required this.overlay1,
    required this.overlay2,
    required this.overlay3,
    required this.overlay4,
    required this.overlay5,
    required this.overlay6,
    required this.overlay7,
    required this.overlay8,
    required this.overlay9,
    required this.overlay10,
    required this.background,
    required this.primary,
    required this.primary2,
    required this.primary3,
  });

  factory ColorScheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return ColorScheme._raw(
          background: _Colors.darkBackground,
          overlay1: _Colors.darkOverlay1,
          overlay2: _Colors.darkOverlay2,
          overlay3: _Colors.darkOverlay3,
          overlay4: _Colors.darkOverlay4,
          overlay5: _Colors.darkOverlay5,
          overlay6: _Colors.darkOverlay6,
          overlay7: _Colors.darkOverlay7,
          overlay8: _Colors.darkOverlay8,
          overlay9: _Colors.darkOverlay9,
          overlay10: _Colors.darkOverlay10,
          primary: _Colors.darkPrimary,
          primary2: _Colors.darkPrimary2,
          primary3: _Colors.darkPrimary3,
        );
      case Brightness.light:
        return ColorScheme._raw(
          background: _Colors.lightBackground,
          overlay1: _Colors.lightOverlay1,
          overlay2: _Colors.lightOverlay2,
          overlay3: _Colors.lightOverlay3,
          overlay4: _Colors.lightOverlay4,
          overlay5: _Colors.lightOverlay5,
          overlay6: _Colors.lightOverlay6,
          overlay7: _Colors.lightOverlay7,
          overlay8: _Colors.lightOverlay8,
          overlay9: _Colors.lightOverlay9,
          overlay10: _Colors.lightOverlay10,
          primary: _Colors.lightPrimary,
          primary2: _Colors.lightPrimary2,
          primary3: _Colors.lightPrimary3,
        );
    }
  }

  final Color overlay1;

  final Color overlay2;

  final Color overlay3;

  final Color overlay4;

  final Color overlay5;

  final Color overlay6;

  final Color overlay7;

  final Color overlay8;

  final Color overlay9;

  final Color overlay10;

  final Color primary;

  final Color primary2;

  final Color primary3;

  final Color background;
}
