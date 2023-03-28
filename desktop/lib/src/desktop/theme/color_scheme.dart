import 'dart:ui' show Brightness;

import 'package:flutter/widgets.dart';

export 'theme_data.dart' show ThemeData, Theme;

const PrimaryColor _kDefaultPrimary = PrimaryColor._dodgerBlue;

/// Color scheme used for the theme data.
@immutable
class ColorScheme {
  ///
  const ColorScheme(
    this.brightness, {
    PrimaryColor? primary,
    BackgroundColor? backgroundColor,
    ShadeColor? shade,
  })  : _primary = primary ?? _kDefaultPrimary,
        _background = backgroundColor ?? const _DefaultBackgroundColor._(0.0),
        _shade = shade;

  /// Returns a color scheme with a different brightness.
  ColorScheme withBrightness(Brightness brightness) {
    return ColorScheme(brightness, primary: _primary);
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

  final ShadeColor? _shade;

  /// Shade color.
  ShadeColor get shade =>
      _shade ?? _DefaultShadeColor._(brightness: brightness);

  /// Primary color.
  PrimaryColor get primary => _primary.withBrightness(brightness);

  /// Background color.
  BackgroundColor get background => _background.withBrightness(brightness);

  /// Disabled color.
  Color get disabled => brightness == Brightness.light
      ? const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.75).toColor()
      : const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.25).toColor();

  /// Error color.
  Color get error => brightness == Brightness.light
      ? const HSLColor.fromAHSL(1.0, 0, 0.9, 0.5).toColor()
      : const HSLColor.fromAHSL(1.0, 0, 0.65, 0.55).toColor();
}

/// Shade color used in [ColorScheme].
abstract class ShadeColor {
  ///
  const ShadeColor();

  /// Returns a shade color.
  Color operator [](int index);
}

class _DefaultShadeColor extends ShadeColor {
  ///
  const _DefaultShadeColor._({
    Brightness? brightness,
  }) : _brightness = brightness;

  static const double _alpha = 1.0;
  static const double _hue = 0.0;
  static const double _saturation = 0.0;

  final Brightness? _brightness;

  /// Returns a shade color.
  @override
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 30:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.37)
                .toColor();
          case 40:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.46)
                .toColor();
          case 50:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.55)
                .toColor();
          case 60:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.64)
                .toColor();
          case 70:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.73)
                .toColor();
          case 80:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.82)
                .toColor();
          case 90:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.91)
                .toColor();
          case 100:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 1.0)
                .toColor();
          default:
            throw Exception('Wrong index for shade color');
        }
      case Brightness.light:
        switch (index) {
          case 30:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.63)
                .toColor();
          case 40:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.54)
                .toColor();
          case 50:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.45)
                .toColor();
          case 60:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.36)
                .toColor();
          case 70:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.27)
                .toColor();
          case 80:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.18)
                .toColor();
          case 90:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.09)
                .toColor();
          case 100:
            return const HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.0)
                .toColor();
          default:
            throw Exception('Wrong index for shade color');
        }
      default:
        return const Color(0x0);
    }
  }
}

/// The background color used in [ColorScheme].
abstract class BackgroundColor {
  ///
  const BackgroundColor();

  /// Returns the [BackgroundColor] with a different brightness.
  BackgroundColor withBrightness(Brightness brightness);

  /// Returns a background color.
  Color operator [](int index);
}

class _DefaultBackgroundColor extends BackgroundColor {
  const _DefaultBackgroundColor._(
    double lightness, {
    Brightness? brightness,
  })  : _brightness = brightness,
        _lightness = lightness;

  static const double _alpha = 1.0;
  static const double _hue = 0.0;
  static const double _saturation = 0.0;
  final double _lightness;

  /// Override this function to return a custom background color.
  @override
  BackgroundColor withBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return _DefaultBackgroundColor._(0.0, brightness: brightness);
      case Brightness.light:
        return _DefaultBackgroundColor._(1.0, brightness: brightness);
    }
  }

  @override
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 0:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.0)
                .toColor();
          case 4:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.04)
                .toColor();
          case 8:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.08)
                .toColor();
          case 12:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.12)
                .toColor();
          case 16:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.16)
                .toColor();
          case 20:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.2)
                .toColor();
          default:
            throw Exception('Wrong index for backgrount color');
        }
      case Brightness.light:
        switch (index) {
          case 0:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, _lightness)
                .toColor();
          case 4:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.04)
                .toColor();
          case 8:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.08)
                .toColor();
          case 12:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.12)
                .toColor();
          case 16:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.16)
                .toColor();
          case 20:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.2)
                .toColor();
          default:
            throw Exception('Wrong index for backgrount color');
        }
      default:
        return const Color(0x0);
    }
  }

  final Brightness? _brightness;
}

/// Primary color used for color scheme.
@immutable
class PrimaryColor {
  const PrimaryColor._(
    this._name,
    double alpha,
    double hue,
    double saturation,
    double lightness, {
    Brightness? brightness,
  })  : _brightness = brightness,
        _alpha = alpha,
        _hue = hue,
        _saturation = saturation,
        _lightness = lightness;

  final double _alpha;
  final double _hue;
  final double _saturation;
  final double _lightness;

  @override
  int get hashCode {
    return Object.hash(
      _alpha,
      _hue,
      _lightness,
      _saturation,
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
    return other is PrimaryColor &&
        other._alpha == _alpha &&
        other._hue == _hue &&
        other._lightness == _lightness &&
        other._saturation == _saturation;
  }

  /// Returns a primary color.
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 30:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.3).toColor();
          case 40:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.4).toColor();
          case 50:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.5).toColor();
          case 60:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.6).toColor();
          case 70:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.7).toColor();
          default:
            throw Exception('Wrong index for primary color');
        }
      case Brightness.light:
        switch (index) {
          case 30:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.7).toColor();
          case 40:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.6).toColor();
          case 50:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.5).toColor();
          case 60:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.4).toColor();
          case 70:
            return HSLColor.fromAHSL(_alpha, _hue, _saturation, 0.3).toColor();
          default:
            throw Exception('Wrong index for primary color');
        }
      default:
        return const Color(0x0);
    }
  }

  /// Returns the color with difference in lightness.
  Color get color =>
      HSLColor.fromAHSL(_alpha, _hue, _saturation, _lightness).toColor();

  /// [PrimaryColor] with a specific [Brightness].
  PrimaryColor withBrightness(Brightness brightness) {
    return PrimaryColor._(_name, _alpha, _hue, _saturation, _lightness,
        brightness: brightness);
  }

  final String _name;

  final Brightness? _brightness;

  @override
  String toString() => _name.toString();

  static const _coral = PrimaryColor._('Coral', 1.0, 16, 1.0, 0.66);
  static const _cornflowerBlue =
      PrimaryColor._('Cornflower Blue', 1.0, 219, 0.79, 0.66);
  static const _turquoise = PrimaryColor._('Turquoise', 1.0, 181, 0.8, 0.41);
  static const _deepSkyBlue =
      PrimaryColor._('Deep Sky Blue', 1.0, 195, 1.0, 0.5);
  static const _dodgerBlue = PrimaryColor._('Dodger Blue', 1.0, 210, 0.9, 0.56);
  static const _goldenrod = PrimaryColor._('Goldenrod', 1.0, 43, 0.74, 0.49);
  static const _hotPink = PrimaryColor._('Hot Pink', 1.0, 330, 1.0, 0.7);
  static const _purple = PrimaryColor._('Purple', 1.0, 260, 0.6, 0.65);
  static const _orange = PrimaryColor._('Orange', 1.0, 33, 1.0, 0.5);
  static const _royalBlue = PrimaryColor._('Royal Blue', 1.0, 225, 0.73, 0.57);
  static const _sandyBrown = PrimaryColor._('Sandy Brown', 1.0, 20, 0.87, 0.67);
  static const _slateBlue = PrimaryColor._('Slate Blue', 1.0, 248, 0.53, 0.58);
  static const _steelBlue = PrimaryColor._('Steel Blue', 1.0, 207, 0.44, 0.49);
  static const _violet = PrimaryColor._('Violet', 1.0, 300, 0.76, 0.7);
  static const _springGreen =
      PrimaryColor._('Spring Green', 1.0, 150, 0.8, 0.4);
  static const _red = PrimaryColor._('Red', 1.0, 347.0, 0.9, 0.6);
}

/// Constants for [PrimaryColor].
enum PrimaryColors {
  /// Coral color.
  coral(PrimaryColor._coral),

  /// Cornflower blue color.
  cornflowerBlue(PrimaryColor._cornflowerBlue),

  /// Turquoise color.
  turquoise(PrimaryColor._turquoise),

  /// Deep sky blue color.
  deepSkyBlue(PrimaryColor._deepSkyBlue),

  /// Dodger blue color.
  dodgerBlue(PrimaryColor._dodgerBlue),

  /// Goldenrod color.
  goldenrod(PrimaryColor._goldenrod),

  /// Hot pink color.
  hotPink(PrimaryColor._hotPink),

  /// Purple color.
  purple(PrimaryColor._purple),

  /// Orange color.
  orange(PrimaryColor._orange),

  /// Royal blue color.
  royalBlue(PrimaryColor._royalBlue),

  /// Sandy brown color.
  sandyBrown(PrimaryColor._sandyBrown),

  /// Slate blue color.
  slateBlue(PrimaryColor._slateBlue),

  /// Steel blue color.
  steelBlue(PrimaryColor._steelBlue),

  /// Violet color.
  violet(PrimaryColor._violet),

  /// Spring green color.
  springGreen(PrimaryColor._springGreen),

  /// Red color.
  red(PrimaryColor._red);

  /// Creates a [PrimaryColors] enumeration.
  const PrimaryColors(this._primaryColor);

  final PrimaryColor _primaryColor;

  /// The [PrimaryColor].
  PrimaryColor get primaryColor => _primaryColor;

  @override
  String toString() => primaryColor.toString();

  /// Tries to create a [PrimaryColors] enumeration from a [PrimaryColor] value.
  /// Returns null if the value is a custom primary color.
  static PrimaryColors? fromPrimaryColor(PrimaryColor primaryColor) {
    if (primaryColor == PrimaryColors.coral._primaryColor) {
      return PrimaryColors.coral;
    } else if (primaryColor == PrimaryColors.cornflowerBlue._primaryColor) {
      return PrimaryColors.cornflowerBlue;
    } else if (primaryColor == PrimaryColors.turquoise._primaryColor) {
      return PrimaryColors.turquoise;
    } else if (primaryColor == PrimaryColors.deepSkyBlue._primaryColor) {
      return PrimaryColors.deepSkyBlue;
    } else if (primaryColor == PrimaryColors.dodgerBlue._primaryColor) {
      return PrimaryColors.dodgerBlue;
    } else if (primaryColor == PrimaryColors.goldenrod._primaryColor) {
      return PrimaryColors.goldenrod;
    } else if (primaryColor == PrimaryColors.hotPink._primaryColor) {
      return PrimaryColors.hotPink;
    } else if (primaryColor == PrimaryColors.purple._primaryColor) {
      return PrimaryColors.purple;
    } else if (primaryColor == PrimaryColors.orange._primaryColor) {
      return PrimaryColors.orange;
    } else if (primaryColor == PrimaryColors.royalBlue._primaryColor) {
      return PrimaryColors.royalBlue;
    } else if (primaryColor == PrimaryColors.sandyBrown._primaryColor) {
      return PrimaryColors.sandyBrown;
    } else if (primaryColor == PrimaryColors.slateBlue._primaryColor) {
      return PrimaryColors.slateBlue;
    } else if (primaryColor == PrimaryColors.steelBlue._primaryColor) {
      return PrimaryColors.steelBlue;
    } else if (primaryColor == PrimaryColors.violet._primaryColor) {
      return PrimaryColors.violet;
    } else if (primaryColor == PrimaryColors.springGreen._primaryColor) {
      return PrimaryColors.springGreen;
    } else if (primaryColor == PrimaryColors.red._primaryColor) {
      return PrimaryColors.red;
    }

    return null;
  }
}
