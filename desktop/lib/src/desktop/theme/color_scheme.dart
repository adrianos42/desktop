import 'dart:ui' show Brightness;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

const PrimaryColor _kDefaultPrimary = PrimaryColor.dodgerBlue;

/// Color scheme used for the theme data.
@immutable
class ColorScheme {
  ///
  const ColorScheme(
    this.brightness, [
    PrimaryColor? primary,
    BackgroundColor? backgroundColor,
  ])  : _primary = primary ?? _kDefaultPrimary,
        _background = backgroundColor ?? const BackgroundColor._(0.0);

  /// Returns a color scheme with a different brightness.
  ColorScheme withBrightness(Brightness brightness) {
    return ColorScheme(brightness, _primary);
  }

  /// Calculates a color lightness according to the current brightness.
  Color shadeColorFromLightness(Color value) {
    // TODO(as): See the contrast in colors.
    if (brightness == Brightness.dark) {
      return HSLColor.fromColor(value).withLightness(0.8).toColor();
    }
    return HSLColor.fromColor(value).withLightness(0.2).toColor();
  }

  final PrimaryColor _primary;

  final BackgroundColor _background;

  /// The color scheme brightness.
  final Brightness brightness;

  /// The background lightness percentage difference.
  //final double backgroundDifference;

  /// Primary color.
  PrimaryColor get primary => _primary._withBrightness(brightness);

  /// Background color.
  BackgroundColor get background {
    final BackgroundColor color = _background.withBrightness(brightness);
    if (brightness == Brightness.dark && color.lightness > 0.1 ||
        brightness == Brightness.light && color.lightness < 0.9) {
      throw Exception('Invalid background color lightness.');
    }
    return color;
  }

  /// Disabled color.
  Color get disabled => brightness == Brightness.light
      ? const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.75).toColor()
      : const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.25).toColor();

  /// Error color.
  Color get error => const HSLColor.fromAHSL(1.0, 0, 0.8, 0.5).toColor();

  /// Shade color.
  ShadeColor get shade => ShadeColor._withBrightness(brightness);
}

/// Shade color used for color scheme.
class ShadeColor extends HSLColor {
  const ShadeColor._(
    double lightness, {
    Brightness? brightness,
  })  : _brightness = brightness,
        super.fromAHSL(
          1.0,
          0.0,
          0.0,
          lightness,
        );

  factory ShadeColor._withBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return ShadeColor._(1.0, brightness: brightness);
      case Brightness.light:
        return ShadeColor._(0.0, brightness: brightness);
    }
  }

  /// Returns a shade color.
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 30:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.3).toColor();
          case 40:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.4).toColor();
          case 50:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.5).toColor();
          case 60:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.6).toColor();
          case 70:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.7).toColor();
          case 80:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.8).toColor();
          case 90:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.9).toColor();
          case 100:
            return HSLColor.fromAHSL(alpha, hue, saturation, 1.0).toColor();
          default:
            throw Exception('Wrong index for shade color');
        }
      case Brightness.light:
        switch (index) {
          case 30:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.7).toColor();
          case 40:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.6).toColor();
          case 50:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.5).toColor();
          case 60:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.4).toColor();
          case 70:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.3).toColor();
          case 80:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.2).toColor();
          case 90:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.1).toColor();
          case 100:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.0).toColor();
          default:
            throw Exception('Wrong index for shade color');
        }
    }
  }

  final Brightness? _brightness;
}

/// Background color used for color scheme.
class BackgroundColor extends HSLColor {
  ///
  const BackgroundColor._(
    double lightness, {
    Brightness? brightness,
  })  : _brightness = brightness,
        super.fromAHSL(
          1.0,
          0.0,
          0.0,
          lightness,
        );

  /// Override this function to return a custom background color.
  BackgroundColor withBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return BackgroundColor._(0.0, brightness: brightness);
      case Brightness.light:
        return BackgroundColor._(1.0, brightness: brightness);
    }
  }

  /// Returns a background color.
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 0:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.0)
                .toColor();
          case 2:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.02)
                .toColor();
          case 4:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.04)
                .toColor();
          case 6:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.06)
                .toColor();
          case 8:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.08)
                .toColor();
          case 10:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.1)
                .toColor();
          case 12:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.12)
                .toColor();
          case 14:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.14)
                .toColor();
          case 16:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.16)
                .toColor();
          case 18:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.18)
                .toColor();
          case 20:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness + 0.2)
                .toColor();
          default:
            throw Exception('Wrong index for backgrount color');
        }
      case Brightness.light:
        switch (index) {
          case 0:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness)
                .toColor();
          case 2:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.02)
                .toColor();
          case 4:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.04)
                .toColor();
          case 6:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.06)
                .toColor();
          case 8:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.08)
                .toColor();
          case 10:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.1)
                .toColor();
          case 12:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.12)
                .toColor();
          case 14:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.14)
                .toColor();
          case 16:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.16)
                .toColor();
          case 18:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.18)
                .toColor();
          case 20:
            return HSLColor.fromAHSL(alpha, hue, saturation, lightness - 0.2)
                .toColor();
          default:
            throw Exception('Wrong index for backgrount color');
        }
    }
  }

  final Brightness? _brightness;
}

/// Primary color used for color scheme.
class PrimaryColor extends HSLColor {
  const PrimaryColor._(
    this._name,
    double alpha,
    double hue,
    double saturation,
    double lightness, {
    Brightness? brightness,
  })  : _brightness = brightness,
        super.fromAHSL(
          alpha,
          hue,
          saturation,
          lightness,
        );

  /// Returns a primary color.
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 30:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.3).toColor();
          case 40:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.4).toColor();
          case 50:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.5).toColor();
          case 60:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.6).toColor();
          case 70:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.7).toColor();
          default:
            throw Exception('Wrong index for primary color');
        }
      case Brightness.light:
        switch (index) {
          case 30:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.7).toColor();
          case 40:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.6).toColor();
          case 50:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.5).toColor();
          case 60:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.4).toColor();
          case 70:
            return HSLColor.fromAHSL(alpha, hue, saturation, 0.3).toColor();
          default:
            throw Exception('Wrong index for primary color');
        }
    }
  }

  PrimaryColor _withBrightness(Brightness brightness) {
    return PrimaryColor._(_name, alpha, hue, saturation, 0.5,
        brightness: brightness);
  }

  final String _name;

  final Brightness? _brightness;

  @override
  String toString() => _name.toString();

  /// Coral color.
  static const coral = PrimaryColor._('Coral', 1.0, 16, 1.0, 0.66);

  /// Cornflower blue color.
  static const cornflowerBlue =
      PrimaryColor._('Cornflower Blue', 1.0, 219, 0.79, 0.66);

  /// Turquoise color.
  static const turquoise = PrimaryColor._('Turquoise', 1.0, 181, 0.8, 0.41);

  /// Deep sky blue color.
  static const deepSkyBlue =
      PrimaryColor._('Deep Sky Blue', 1.0, 195, 1.0, 0.5);

  /// Dodger blue color.
  static const dodgerBlue = PrimaryColor._('Dodger Blue', 1.0, 210, 0.9, 0.56);

  /// Golden rod color.
  static const goldenrod = PrimaryColor._('Goldenrod', 1.0, 43, 0.74, 0.49);

  /// Hot pink color.
  static const hotPink = PrimaryColor._('Hot Pink', 1.0, 330, 1.0, 0.7);

  /// Purple color.
  static const purple = PrimaryColor._('Purple', 1.0, 260, 0.6, 0.65);

  /// Orange color.
  static const orange = PrimaryColor._('Orange', 1.0, 33, 1.0, 0.5);

  /// Orchid color.
  static const orchid = PrimaryColor._('Orchid', 1.0, 302, 0.59, 0.65);

  /// Royal blue color.
  static const royalBlue = PrimaryColor._('Royal Blue', 1.0, 225, 0.73, 0.57);

  /// Sandy brown color.
  static const sandyBrown = PrimaryColor._('Sandy Brown', 1.0, 20, 0.87, 0.67);

  /// Slate blue color.
  static const slateBlue = PrimaryColor._('Slate Blue', 1.0, 248, 0.53, 0.58);

  /// Steel blue color.
  static const steelBlue = PrimaryColor._('Steel Blue', 1.0, 207, 0.44, 0.49);

  /// Violet color.
  static const violet = PrimaryColor._('Violet', 1.0, 300, 0.76, 0.7);

  /// Spring green color.
  static const springGreen = PrimaryColor._('Spring Green', 1.0, 150, 0.8, 0.4);

  /// Red color.
  static const red = PrimaryColor._('Red', 1.0, 347.0, 0.9, 0.6);
}
