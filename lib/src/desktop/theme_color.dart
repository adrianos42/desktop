import 'dart:ui' show Brightness;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

const HSLColor _kBlack = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.0);
const HSLColor _kWhite = HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0);
const HSLColor kDefaultPrimary = HSLColor.fromAHSL(1.0, 210.0, 0.86, 0.5);

@immutable
class ColorScheme {
  ColorScheme(this.brightness, HSLColor primary)
      : assert(primary.lightness >= 0.4),
        assert(primary.lightness <= 0.8),
        assert(primary.saturation >= 0.5),
        _primary = primary;

  ColorScheme withBrightness(Brightness brightness) {
    return ColorScheme(brightness, _primary);
  }

  final Brightness brightness;

  final HSLColor _primary;

  HSLColor get overlay1 => background.withAlpha(0.9);
  HSLColor get overlay2 => background.withAlpha(0.8);
  HSLColor get overlay3 => background.withAlpha(0.7);
  HSLColor get overlay4 => background.withAlpha(0.6);
  HSLColor get overlay5 => background.withAlpha(0.5);
  HSLColor get overlay6 => background.withAlpha(0.4);
  HSLColor get overlay7 => background.withAlpha(0.3);
  HSLColor get overlay8 => background.withAlpha(0.2);
  HSLColor get overlay9 => background.withAlpha(0.1);

  HSLColor get primary => brightness == Brightness.dark
      ? _primary.withLightness(_primary.lightness + 0.1)
      : _primary.withLightness(_primary.lightness - 0.1);

  HSLColor get primary1 => primary.withSaturation(_primary.saturation - 0.2);
  HSLColor get primary2 => primary.withSaturation(_primary.saturation - 0.4);

  HSLColor get background => _backgroundFromIntensity(1.0);
  HSLColor get background1 => _backgroundFromIntensity(0.9);
  HSLColor get background2 => _backgroundFromIntensity(0.85);
  HSLColor get background3 => _backgroundFromIntensity(0.80);
  HSLColor get background4 => _backgroundFromIntensity(0.75);

  HSLColor _backgroundFromIntensity(double value) {
    return HSLColor.fromAHSL(
        1.0, 0.0, 0.0, brightness == Brightness.light ? value : 1.0 - value);
  }
}

class Colors {
  static const aliceBlue = HSLColor.fromAHSL(1.0, 208, 1.0, 0.97);
  static const antiqueWhite = HSLColor.fromAHSL(1.0, 34.0, 0.78, 0.91);
  static const aquamarine = HSLColor.fromAHSL(1.0, 160, 1.0, 0.75);
  static const azure = HSLColor.fromAHSL(1.0, 180.0, 1.0, 0.97);
  static const beige = HSLColor.fromAHSL(1.0, 60, 0.56, 0.91);
  static const bisque = HSLColor.fromAHSL(1.0, 33.0, 1.0, 0.88);
  static const black = HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0);
  static const blanchedAlmond = HSLColor.fromAHSL(1.0, 36.0, 1.0, 0.9);
  static const blue = HSLColor.fromAHSL(1.0, 240, 1.0, 0.5);
  static const blueViolet = HSLColor.fromAHSL(1.0, 271, 0.76, 0.53);
  static const brown = HSLColor.fromAHSL(1.0, 0, 0.59, 0.41);
  static const burlywood = HSLColor.fromAHSL(1.0, 34, 0.57, 0.7);
  static const cadetBlue = HSLColor.fromAHSL(1.0, 182, 0.25, 0.5);
  static const chartreuse = HSLColor.fromAHSL(1.0, 90, 1.0, 0.5);
  static const chocolate = HSLColor.fromAHSL(1.0, 25, 0.75, 0.47);
  static const coral = HSLColor.fromAHSL(1.0, 16, 1.0, 0.66);
  static const cornflowerBlue = HSLColor.fromAHSL(1.0, 219, 0.79, 0.66);
  static const cornsilk = HSLColor.fromAHSL(1.0, 48.0, 1.0, 0.93);
  static const cyan = HSLColor.fromAHSL(1.0, 180, 1.0, 0.5);
  static const darkGoldenrod = HSLColor.fromAHSL(1.0, 43, 0.89, 0.38);
  static const darkGreen = HSLColor.fromAHSL(1.0, 120, 1.0, 0.2);
  static const darkKhaki = HSLColor.fromAHSL(1.0, 56, 0.38, 0.58);
  static const darkOliveGreen = HSLColor.fromAHSL(1.0, 82, 0.39, 0.3);
  static const darkOrange = HSLColor.fromAHSL(1.0, 0.33, 1.0, 0.5);
  static const darkOrchid = HSLColor.fromAHSL(1.0, 280, 0.61, 0.5);
  static const darkSalmon = HSLColor.fromAHSL(1.0, 15, 0.72, 0.7);
  static const darkSeaGreen = HSLColor.fromAHSL(1.0, 120, 0.25, 0.65);
  static const darkSlateBlue = HSLColor.fromAHSL(1.0, 248, 0.39, 0.39);
  static const darkSlateGray = HSLColor.fromAHSL(1.0, 25, 0.25, 0.25);
  static const darkTurquoise = HSLColor.fromAHSL(1.0, 181, 1.0, 0.41);
  static const darkViolet = HSLColor.fromAHSL(1.0, 282, 1.0, 0.41);
  static const deepPink = HSLColor.fromAHSL(1.0, 328, 1.0, 0.54);
  static const deepSkyBlue = HSLColor.fromAHSL(1.0, 195, 1.0, 0.5);
  static const dimGray = HSLColor.fromAHSL(1.0, 0, 0.0, 0.41);
  static const dodgerBlue = HSLColor.fromAHSL(1.0, 210, 1.0, 0.56);
  static const firebrick = HSLColor.fromAHSL(1.0, 0, 0.68, 0.42);
  static const floralWhite = HSLColor.fromAHSL(1.0, 40.0, 1.0, 0.97);
  static const forestGreen = HSLColor.fromAHSL(1.0, 120, 0.61, 0.34);
  static const gainsboro = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.86);
  static const ghostWhite = HSLColor.fromAHSL(1.0, 240.0, 1.0, 0.99);
  static const gold = HSLColor.fromAHSL(1.0, 51, 1.0, 0.5);
  static const goldenrod = HSLColor.fromAHSL(1.0, 43, 0.74, 0.49);
  static const gray = HSLColor.fromAHSL(1.0, 0.0, 0, 0.75);
  static const green = HSLColor.fromAHSL(1.0, 120, 1.0, 0.5);
  static const greenYellow = HSLColor.fromAHSL(1.0, 84, 1.0, 0.59);
  static const honeydew = HSLColor.fromAHSL(1.0, 120.0, 1.0, 0.97);
  static const hotPink = HSLColor.fromAHSL(1.0, 330, 1.0, 0.71);
  static const indianRed = HSLColor.fromAHSL(1.0, 0, 0.53, 0.58);
  static const ivory = HSLColor.fromAHSL(1.0, 60.0, 1.0, 0.97);
  static const khaki = HSLColor.fromAHSL(1.0, 54, 0.77, 0.75);
  static const lavender = HSLColor.fromAHSL(1.0, 240, 0.67, 0.94);
  static const lavenderBlush = HSLColor.fromAHSL(1.0, 340, 1.0, 0.97);
  static const lawnGreen = HSLColor.fromAHSL(1.0, 90, 1.0, 0.5);
  static const lemonChiffon = HSLColor.fromAHSL(1.0, 54.0, 1.0, 0.9);
  static const lightBlue = HSLColor.fromAHSL(1.0, 195, 0.53, 0.79);
  static const lightCoral = HSLColor.fromAHSL(1.0, 0, 0.79, 0.72);
  static const lightCyan = HSLColor.fromAHSL(1.0, 180, 1.0, 0.94);
  static const lightGoldenrod = HSLColor.fromAHSL(1.0, 51, 0.76, 0.72);
  static const lightGoldenrodYellow = HSLColor.fromAHSL(1.0, 60, 0.8, 0.9);
  static const lightGray = HSLColor.fromAHSL(1.0, 0, 0.0, 0.83);
  static const lightPink = HSLColor.fromAHSL(1.0, 351, 1.0, 0.86);
  static const lightSalmon = HSLColor.fromAHSL(1.0, 17, 1.0, 0.74);
  static const lightSeaGreen = HSLColor.fromAHSL(1.0, 177, 0.7, 0.41);
  static const lightSkyBlue = HSLColor.fromAHSL(1.0, 203, 0.92, 0.75);
  static const lightSlateBlue = HSLColor.fromAHSL(1.0, 248, 1.0, 0.72);
  static const lightSlateGray = HSLColor.fromAHSL(1.0, 210, 0.14, 0.53);
  static const lightSteelBlue = HSLColor.fromAHSL(1.0, 214, 0.41, 0.78);
  static const lightYellow = HSLColor.fromAHSL(1.0, 60, 1.0, 0.94);
  static const limeGreen = HSLColor.fromAHSL(1.0, 120, 0.61, 0.5);
  static const linen = HSLColor.fromAHSL(1.0, 30.0, 0.67, 0.94);
  static const magenta = HSLColor.fromAHSL(1.0, 300, 1.0, 0.5);
  static const maroon = HSLColor.fromAHSL(1.0, 338, 0.57, 0.44);
  static const mediumAquamarine = HSLColor.fromAHSL(1.0, 160, 0.5, 0.6);
  static const mediumBlue = HSLColor.fromAHSL(1.0, 240, 1.0, 0.4);
  static const mediumOrchid = HSLColor.fromAHSL(1.0, 288, 0.59, 0.58);
  static const mediumPurple = HSLColor.fromAHSL(1.0, 260, 0.6, 0.65);
  static const mediumSeaGreen = HSLColor.fromAHSL(1.0, 147, 0.5, 0.47);
  static const mediumSlateBlue = HSLColor.fromAHSL(1.0, 249, 0.8, 0.67);
  static const mediumSpringGreen = HSLColor.fromAHSL(1.0, 157, 1.0, 0.5);
  static const mediumTurquoise = HSLColor.fromAHSL(1.0, 178, 0.6, 0.55);
  static const mediumVioletRed = HSLColor.fromAHSL(1.0, 322, 0.81, 0.43);
  static const midnightBlue = HSLColor.fromAHSL(1.0, 240, 0.64, 0.27);
  static const mintCream = HSLColor.fromAHSL(1.0, 150.0, 1.0, 0.98);
  static const mistyRose = HSLColor.fromAHSL(1.0, 6.0, 1.0, 0.94);
  static const moccasin = HSLColor.fromAHSL(1.0, 38.0, 1.0, 0.85);
  static const navajoWhite = HSLColor.fromAHSL(1.0, 36.0, 1.0, 0.84);
  static const navyBlue = HSLColor.fromAHSL(1.0, 240, 1.0, 0.25);
  static const oldLace = HSLColor.fromAHSL(1.0, 39.0, 0.85, 0.95);
  static const oliveDrab = HSLColor.fromAHSL(1.0, 80, 0.6, 0.35);
  static const orange = HSLColor.fromAHSL(1.0, 39, 1.0, 0.5);
  static const orangeRed = HSLColor.fromAHSL(1.0, 16, 1.0, 0.5);
  static const orchid = HSLColor.fromAHSL(1.0, 302, 0.59, 0.65);
  static const paleGoldenrod = HSLColor.fromAHSL(1.0, 55, 0.67, 0.8);
  static const paleGreen = HSLColor.fromAHSL(1.0, 120, 0.93, 0.79);
  static const paleTurquoise = HSLColor.fromAHSL(1.0, 180, 0.65, 0.81);
  static const paleVioletRed = HSLColor.fromAHSL(1.0, 340, 0.6, 0.65);
  static const papayaWhip = HSLColor.fromAHSL(1.0, 37.0, 1.0, 0.92);
  static const peachPuff = HSLColor.fromAHSL(1.0, 28.0, 1.0, 0.86);
  static const peru = HSLColor.fromAHSL(1.0, 30, 0.59, 0.53);
  static const pink = HSLColor.fromAHSL(1.0, 350, 1.0, 0.88);
  static const plum = HSLColor.fromAHSL(1.0, 300, 0.47, 0.75);
  static const powderBlue = HSLColor.fromAHSL(1.0, 187, 0.52, 0.8);
  static const purple = HSLColor.fromAHSL(1.0, 277, 0.87, 0.53);
  static const red = HSLColor.fromAHSL(1.0, 0, 1.0, 0.5);
  static const rosyBrown = HSLColor.fromAHSL(1.0, 0, 0.25, 0.65);
  static const royalBlue = HSLColor.fromAHSL(1.0, 225, 0.73, 0.57);
  static const saddleBrown = HSLColor.fromAHSL(1.0, 25, 0.76, 0.31);
  static const salmon = HSLColor.fromAHSL(1.0, 6, 0.93, 0.71);
  static const sandyBrown = HSLColor.fromAHSL(1.0, 20, 0.87, 0.67);
  static const seaGreen = HSLColor.fromAHSL(1.0, 146, 0.5, 0.36);
  static const seashell = HSLColor.fromAHSL(1.0, 25.0, 1.0, 0.97);
  static const sienna = HSLColor.fromAHSL(1.0, 19, 0.56, 0.4);
  static const skyBlue = HSLColor.fromAHSL(1.0, 197, 0.71, 0.73);
  static const slateBlue = HSLColor.fromAHSL(1.0, 248, 0.53, 0.58);
  static const slateGray = HSLColor.fromAHSL(1.0, 210, 0.13, 0.5);
  static const snow = HSLColor.fromAHSL(1.0, 0.0, 1.0, 0.99);
  static const springGreen = HSLColor.fromAHSL(1.0, 150, 1.0, 0.5);
  static const steelBlue = HSLColor.fromAHSL(1.0, 207, 0.44, 0.49);
  static const tan = HSLColor.fromAHSL(1.0, 34, 0.44, 0.69);
  static const thistle = HSLColor.fromAHSL(1.0, 300, 0.24, 0.8);
  static const tomato = HSLColor.fromAHSL(1.0, 9, 1.0, 0.64);
  static const turquoise = HSLColor.fromAHSL(1.0, 174, 0.72, 0.56);
  static const violet = HSLColor.fromAHSL(1.0, 300, 0.76, 0.72);
  static const violetRed = HSLColor.fromAHSL(1.0, 322, 0.73, 0.47);
  static const wheat = HSLColor.fromAHSL(1.0, 39, 0.77, 0.83);
  static const white = HSLColor.fromAHSL(1.0, 0.0, 1.0, 1.0);
  static const whiteSmoke = HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.96);
  static const yellow = HSLColor.fromAHSL(1.0, 60, 1.0, 0.5);
  static const yellowGreen = HSLColor.fromAHSL(1.0, 80, 0.61, 0.5);
}

class PrimaryColors {
  static const blueViolet = HSLColor.fromAHSL(1.0, 271, 0.76, 0.53);
  static const brown = HSLColor.fromAHSL(1.0, 0, 0.59, 0.41);
  static const burlywood = HSLColor.fromAHSL(1.0, 34, 0.57, 0.7);
  static const chartreuse = HSLColor.fromAHSL(1.0, 90, 1.0, 0.5);
  static const chocolate = HSLColor.fromAHSL(1.0, 25, 0.75, 0.47);
  static const coral = HSLColor.fromAHSL(1.0, 16, 1.0, 0.66);
  static const cornflowerBlue = HSLColor.fromAHSL(1.0, 219, 0.79, 0.66);
  static const deepPink = HSLColor.fromAHSL(1.0, 328, 1.0, 0.54);
  static const deepSkyBlue = HSLColor.fromAHSL(1.0, 195, 1.0, 0.5);
  static const dodgerBlue = HSLColor.fromAHSL(1.0, 210, 1.0, 0.56);
  static const goldenrod = HSLColor.fromAHSL(1.0, 43, 0.74, 0.49);
  static const green = HSLColor.fromAHSL(1.0, 120, 1.0, 0.5);
  static const hotPink = HSLColor.fromAHSL(1.0, 330, 1.0, 0.71);
  static const indianRed = HSLColor.fromAHSL(1.0, 0, 0.53, 0.58);
  static const lawnGreen = HSLColor.fromAHSL(1.0, 90, 1.0, 0.5);
  static const limeGreen = HSLColor.fromAHSL(1.0, 120, 0.61, 0.5);
  static const orange = HSLColor.fromAHSL(1.0, 39, 1.0, 0.5);
  static const orangeRed = HSLColor.fromAHSL(1.0, 16, 1.0, 0.5);
  static const orchid = HSLColor.fromAHSL(1.0, 302, 0.59, 0.65);
  static const peru = HSLColor.fromAHSL(1.0, 30, 0.59, 0.53);
  static const purple = HSLColor.fromAHSL(1.0, 277, 0.87, 0.53);
  static const royalBlue = HSLColor.fromAHSL(1.0, 225, 0.73, 0.57);
  static const salmon = HSLColor.fromAHSL(1.0, 6, 0.93, 0.71);
  static const sandyBrown = HSLColor.fromAHSL(1.0, 20, 0.87, 0.67);
  static const skyBlue = HSLColor.fromAHSL(1.0, 197, 0.71, 0.73);
  static const slateBlue = HSLColor.fromAHSL(1.0, 248, 0.53, 0.58);
  static const springGreen = HSLColor.fromAHSL(1.0, 150, 1.0, 0.5);
  static const tomato = HSLColor.fromAHSL(1.0, 9, 1.0, 0.64);
  static const turquoise = HSLColor.fromAHSL(1.0, 174, 0.72, 0.56);
  static const violet = HSLColor.fromAHSL(1.0, 300, 0.76, 0.72);
  static const violetRed = HSLColor.fromAHSL(1.0, 322, 0.73, 0.47);
  static const yellowGreen = HSLColor.fromAHSL(1.0, 80, 0.61, 0.5);
  static const redPink = HSLColor.fromAHSL(1.0, 347.0, 0.9, 0.6);
}
