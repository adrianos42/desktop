import 'dart:ui' show Brightness;

import 'package:flutter/widgets.dart';

const PrimaryColor _kDefaultPrimary = PrimaryColor.dodgerBlue;

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
  Color get error => const HSLColor.fromAHSL(1.0, 0, 0.8, 0.5).toColor();
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
          case 2:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.02)
                .toColor();
          case 4:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.04)
                .toColor();
          case 6:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.06)
                .toColor();
          case 8:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.08)
                .toColor();
          case 10:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.1)
                .toColor();
          case 12:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.12)
                .toColor();
          case 14:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.14)
                .toColor();
          case 16:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.16)
                .toColor();
          case 18:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness + 0.18)
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
          case 2:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.02)
                .toColor();
          case 4:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.04)
                .toColor();
          case 6:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.06)
                .toColor();
          case 8:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.08)
                .toColor();
          case 10:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.1)
                .toColor();
          case 12:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.12)
                .toColor();
          case 14:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.14)
                .toColor();
          case 16:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.16)
                .toColor();
          case 18:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.18)
                .toColor();
          case 20:
            return HSLColor.fromAHSL(
                    _alpha, _hue, _saturation, _lightness - 0.2)
                .toColor();
          default:
            throw Exception('Wrong index for backgrount color');
        }
    }
  }

  final Brightness? _brightness;
}

/// Primary color used for color scheme.
@immutable
class PrimaryColor {
  const PrimaryColor._(
    this._name,
    Color color1,
    Color color2,
    Color color3,
    Color color4, {
    Brightness? brightness,
  })  : _brightness = brightness,
        _color1 = color1,
        _color2 = color2,
        _color3 = color3,
        _color4 = color4;

  final Color _color1;
  final Color _color2;
  final Color _color3;
  final Color _color4;

  @override
  int get hashCode {
    return Object.hash(
      _color1,
      _color2,
      _color3,
      _color4,
      _brightness,
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
        other._color1 == _color1 &&
        other._color2 == _color2 &&
        other._color3 == _color3 &&
        other._color4 == _color4 &&
        other._brightness == _brightness;
  }

  /// Returns a primary color.
  Color operator [](int index) {
    switch (_brightness!) {
      case Brightness.dark:
        switch (index) {
          case 30:
            return _color4;
          case 40:
            return _color3;
          case 50:
            return _color2;
          case 60:
            return _color1;
          default:
            throw Exception('Wrong index for primary color: `$index`');
        }
      case Brightness.light:
        switch (index) {
          case 60:
            return _color4;
          case 50:
            return _color3;
          case 40:
            return _color2;
          case 30:
            return _color1;
          default:
            throw Exception('Wrong index for primary color: `$index`');
        }
    }
  }

  /// Returns the default color.
  Color get color => _color1;

  /// [PrimaryColor] with a specific [Brightness].
  PrimaryColor withBrightness(Brightness brightness) {
    return PrimaryColor._(_name, _color1, _color2, _color3, _color4,
        brightness: brightness);
  }

  final String _name;

  final Brightness? _brightness;

  @override
  String toString() => _name.toString();

  /// Coral color.
  static const coral = PrimaryColor._(
    'Coral',
    Color(0xffff7256),
    Color(0xffee6a50),
    Color(0xffcd5b45),
    Color(0xff8b3e2f),
  );

  /// Cornflower blue color.
  static const cornflowerBlue = PrimaryColor._(
    'Cornflower Blue',
    Color(0xff6495ed),
    Color(0xff),
    Color(0xff),
    Color(0xff),
  );

  /// Turquoise color.
  static const turquoise = PrimaryColor._(
    'Turquoise',
    Color(0xff00f5ff),
    Color(0xff00e5ee),
    Color(0xff00c5cd),
    Color(0xff00868b),
  );

  /// Deep sky blue color.
  static const deepSkyBlue = PrimaryColor._(
    'Deep Sky Blue',
    Color(0xff00bfff),
    Color(0xff00b2ee),
    Color(0xff009acd),
    Color(0xff00688b),
  );

  /// Dodger blue color.
  static const dodgerBlue = PrimaryColor._(
    'Dodger Blue',
    Color(0xff1e90ff),
    Color(0xff1c86ee),
    Color(0xff1874cd),
    Color(0xff104e8b),
  );

  /// Golden rod color.
  static const goldenrod = PrimaryColor._(
    'Goldenrod',
    Color(0xffffc125),
    Color(0xffeeb422),
    Color(0xffcd9b1d),
    Color(0xff8b6914),
  );

  /// Hot pink color.
  static const hotPink = PrimaryColor._(
    'Hot Pink',
    Color(0xffff6eb4),
    Color(0xffee6aa7),
    Color(0xffcd6090),
    Color(0xff8b3a62),
  );

  /// Purple color.
  static const purple = PrimaryColor._(
    'Purple',
    Color(0xff9b30ff),
    Color(0xff912cee),
    Color(0xff7d26cd),
    Color(0xff551a8b),
  );

  /// Orange color.
  static const orange = PrimaryColor._(
    'Orange',
    Color(0xffffa500),
    Color(0xffee9a00),
    Color(0xffcd8500),
    Color(0xff8b5a00),
  );

  /// Orchid color.
  static const orchid = PrimaryColor._(
    'Orchid',
    Color(0xffff83fa),
    Color(0xffee7ae9),
    Color(0xffcd69c9),
    Color(0xff8b4789),
  );

  /// Royal blue color.
  static const royalBlue = PrimaryColor._(
    'Royal Blue',
    Color(0xff4876ff),
    Color(0xff436eee),
    Color(0xff3a5fcd),
    Color(0xff27408b),
  );

  /// Sandy brown color.
  static const sandyBrown = PrimaryColor._(
    'Sandy Brown',
    Color(0xfff4a460),
    Color(0xff),
    Color(0xff),
    Color(0xff),
  );

  /// Slate blue color.
  static const slateBlue = PrimaryColor._(
    'Slate Blue',
    Color(0xff836fff),
    Color(0xff7a67ee),
    Color(0xff6959cd),
    Color(0xff473c8b),
  );

  /// Steel blue color.
  static const steelBlue = PrimaryColor._(
    'Steel Blue',
    Color(0xff63b8ff),
    Color(0xff5cacee),
    Color(0xff4f94cd),
    Color(0xff36648b),
  );

  /// Violet color.
  static const violet = PrimaryColor._(
    'Violet',
    Color(0xffee82ee),
    Color(0xff),
    Color(0xff),
    Color(0xff),
  );

  /// Spring green color.
  static const springGreen = PrimaryColor._(
    'Spring Green',
    Color(0xff00ff7f),
    Color(0xff00ee76),
    Color(0xff00cd66),
    Color(0xff008b45),
  );

  /// Red color.
  static const red = PrimaryColor._(
    'Red',
    Color(0xffff0000),
    Color(0xffee0000),
    Color(0xffcd0000),
    Color(0xff8b0000),
  );
}
