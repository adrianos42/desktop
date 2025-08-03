import 'dart:ui' show Brightness;
import 'package:flutter/widgets.dart';
export 'theme_data.dart' show ThemeData, Theme;

const PrimaryColor _kDefaultPrimary = _DodgerBluePrimaryColor();
const ShadeColor _kDefaultShadeColor = _DefaultShadeColor();
const BackgroundColor _backgroundColor = _DefaultBackgroundColor();

/// Color scheme used for the theme data.
@immutable
class ColorScheme {
  ///
  const ColorScheme({
    PrimaryColor? primary,
    BackgroundColor? backgroundColor,
    ShadeColor? shade,
    Color? disabledColor,
    Color? errorColor,
  })  : _primary = primary ?? _kDefaultPrimary,
        _shade = shade ?? _kDefaultShadeColor,
        _background = backgroundColor ?? _backgroundColor,
        _disabled = disabledColor ?? const Color(0xff404040),
        _error = errorColor ?? const Color(0xffd74242);

  final ShadeColor _shade;
  final PrimaryColor _primary;
  final BackgroundColor _background;
  final Color _disabled;
  final Color _error;

  /// Shade color.
  ShadeColor get shade => _shade;

  /// Primary color.
  PrimaryColor get primary => _primary;

  /// Background color.
  BackgroundColor get background => _background;

  /// Disabled color.
  Color get disabled => _disabled;

  /// Error color.
  Color get error => _error;
}

/// Shade color used in [ColorScheme].
@immutable
abstract class ShadeColor {
  ///
  const ShadeColor({this.brightness = Brightness.dark});

  /// The [Brightness] for this color.
  final Brightness brightness;

  /// Used by [ColorScheme] to return a color with current brightness.
  ShadeColor withBrightness(Brightness brightness);

  /// Light theme color with index `30`.
  Color get w30;

  /// Light theme color with index `40`.
  Color get w40;

  /// Light theme color with index `50`.
  Color get w50;

  /// Light theme color with index `60`.
  Color get w60;

  /// Light theme color with index `70`.
  Color get w70;

  /// Light theme color with index `80`.
  Color get w80;

  /// Light theme color with index `90`.
  Color get w90;

  /// Light theme color with index `100`.
  Color get w100;

  /// Dark theme color with index `30`.
  Color get b30;

  /// Dark theme color with index `40`.
  Color get b40;

  /// Dark theme color with index `50`.
  Color get b50;

  /// Dark theme color with index `60`.
  Color get b60;

  /// Dark theme color with index `70`.
  Color get b70;

  /// Dark theme color with index `80`.
  Color get b80;

  /// Dark theme color with index `90`.
  Color get b90;

  /// Dark theme color with index `100`.
  Color get b100;

  /// Returns a shade color.
  @mustCallSuper
  Color operator [](int index) {
    switch (brightness) {
      case Brightness.light:
        switch (index) {
          case 30:
            return w30;
          case 40:
            return w40;
          case 50:
            return w50;
          case 60:
            return w60;
          case 70:
            return w70;
          case 80:
            return w80;
          case 90:
            return w90;
          case 100:
            return w100;
          default:
            throw Exception('Wrong index for shade color');
        }
      case Brightness.dark:
        switch (index) {
          case 30:
            return b30;
          case 40:
            return b40;
          case 50:
            return b50;
          case 60:
            return b60;
          case 70:
            return b70;
          case 80:
            return b80;
          case 90:
            return b90;
          case 100:
            return b100;
          default:
            throw Exception('Wrong index for shade color');
        }
    }
  }

  @override
  int get hashCode => brightness.hashCode;

  @override
  bool operator ==(covariant ShadeColor other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other.w30 == w30 &&
        other.w40 == w40 &&
        other.w50 == w50 &&
        other.w60 == w60 &&
        other.w70 == w70 &&
        other.w80 == w80 &&
        other.w90 == w90 &&
        other.w100 == w100 &&
        other.b30 == b30 &&
        other.b40 == b40 &&
        other.b50 == b50 &&
        other.b60 == b60 &&
        other.b70 == b70 &&
        other.b80 == b80 &&
        other.b90 == b90 &&
        other.b100 == b100;
  }
}

/// Shade color used in [ColorScheme].
class _DefaultShadeColor extends ShadeColor {
  const _DefaultShadeColor({super.brightness});

  /// Used by [ColorScheme] to return a color with current brightness.
  @override
  ShadeColor withBrightness(Brightness brightness) =>
      _DefaultShadeColor(brightness: brightness);

  /// Light theme color with index `30`.
  @override
  Color get w30 => const Color(0xffa1a1a1);

  /// Light theme color with index `40`.
  @override
  Color get w40 => const Color(0xff8a8a8a);

  /// Light theme color with index `50`.
  @override
  Color get w50 => const Color(0xff737373);

  /// Light theme color with index `60`.
  @override
  Color get w60 => const Color(0xff5c5c5c);

  /// Light theme color with index `70`.
  @override
  Color get w70 => const Color(0xff454545);

  /// Light theme color with index `80`.
  @override
  Color get w80 => const Color(0xff2e2e2e);

  /// Light theme color with index `90`.
  @override
  Color get w90 => const Color(0xff171717);

  /// Light theme color with index `100`.
  @override
  Color get w100 => const Color(0xff000000);

  /// Dark theme color with index `30`.
  @override
  Color get b30 => const Color(0xff5e5e5e);

  /// Dark theme color with index `40`.
  @override
  Color get b40 => const Color(0xff757575);

  /// Dark theme color with index `50`.
  @override
  Color get b50 => const Color(0xff8c8c8c);

  /// Dark theme color with index `60`.
  @override
  Color get b60 => const Color(0xffa3a3a3);

  /// Dark theme color with index `70`.
  @override
  Color get b70 => const Color(0xffbababa);

  /// Dark theme color with index `80`.
  @override
  Color get b80 => const Color(0xffd1d1d1);

  /// Dark theme color with index `90`.
  @override
  Color get b90 => const Color(0xffe8e8e8);

  /// Dark theme color with index `100`.
  @override
  Color get b100 => const Color(0xffffffff);
}

/// The background color used in [ColorScheme].
@immutable
abstract class BackgroundColor {
  ///
  const BackgroundColor({this.brightness = Brightness.dark});

  /// The [Brightness] of the background color.
  final Brightness brightness;

  /// Used by [ColorScheme] to return a color with current brightness.
  BackgroundColor withBrightness(Brightness brightness);

  /// Light theme color with index 0.
  Color get w0;

  /// Light theme color with index 4.
  Color get w4;

  /// Light theme color with index 8.
  Color get w8;

  /// Light theme color with index 12.
  Color get w12;

  /// Light theme color with index 16.
  Color get w16;

  /// Light theme color with index 20.
  Color get w20;

  /// Dark theme color with index 0.
  Color get b0;

  /// Dark theme color with index 4.
  Color get b4;

  /// Dark theme color with index 8.
  Color get b8;

  /// Dark theme color with index 12.
  Color get b12;

  /// Dark theme color with index 16.
  Color get b16;

  /// Dark theme color with index 20.
  Color get b20;

  /// Returns a background color.
  Color operator [](int index) {
    switch (brightness) {
      case Brightness.light:
        switch (index) {
          case 0:
            return w0;
          case 4:
            return w4;
          case 8:
            return w8;
          case 12:
            return w12;
          case 16:
            return w16;
          case 20:
            return w20;
          default:
            throw Exception('Wrong index for backgrount color');
        }
      case Brightness.dark:
        switch (index) {
          case 0:
            return b0;
          case 4:
            return b4;
          case 8:
            return b8;
          case 12:
            return b12;
          case 16:
            return b16;
          case 20:
            return b20;
          default:
            throw Exception('Wrong index for backgrount color');
        }
    }
  }

  @override
  int get hashCode => Object.hash(
        w0,
        w4,
        w8,
        w12,
        w16,
        w20,
        b0,
        b4,
        b8,
        b12,
        b16,
        b20,
      );

  @override
  bool operator ==(covariant BackgroundColor other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other.w0 == w0 &&
        other.w4 == w4 &&
        other.w8 == w8 &&
        other.w12 == w12 &&
        other.w16 == w16 &&
        other.w20 == w20 &&
        other.b0 == b0 &&
        other.b4 == b4 &&
        other.b8 == b8 &&
        other.b12 == b12 &&
        other.b16 == b16 &&
        other.b20 == b20;
  }
}

class _DefaultBackgroundColor extends BackgroundColor {
  const _DefaultBackgroundColor({super.brightness});

  /// Used by [ColorScheme] to return a color with current brightness.
  @override
  BackgroundColor withBrightness(Brightness brightness) =>
      _DefaultBackgroundColor(brightness: brightness);

  /// Light theme color with index 0.
  @override
  Color get w0 => const Color(0xffffffff);

  /// Light theme color with index 4.
  @override
  Color get w4 => const Color(0xfff5f5f5);

  /// Light theme color with index 8.
  @override
  Color get w8 => const Color(0xffebebeb);

  /// Light theme color with index 12.
  @override
  Color get w12 => const Color(0xffe0e0e0);

  /// Light theme color with index 16.
  @override
  Color get w16 => const Color(0xffd6d6d6);

  /// Light theme color with index 20.
  @override
  Color get w20 => const Color(0xffcccccc);

  /// Dark theme color with index 0.
  @override
  Color get b0 => const Color(0xff000000);

  /// Dark theme color with index 4.
  @override
  Color get b4 => const Color(0xff0a0a0a);

  /// Dark theme color with index 8.
  @override
  Color get b8 => const Color(0xff141414);

  /// Dark theme color with index 12.
  @override
  Color get b12 => const Color(0xff1f1f1f);

  /// Dark theme color with index 16.
  @override
  Color get b16 => const Color(0xff292929);

  /// Dark theme color with index 20.
  @override
  Color get b20 => const Color(0xff333333);
}

/// Primary color used for color scheme.
@immutable
abstract class PrimaryColor {
  /// Creates a [PrimaryColor].
  const PrimaryColor({
    required this.name,
  });

  /// The name of the primary color.
  final String name;

  /// Dark theme color with index 30.
  Color get b30;

  /// Dark theme color with index 40.
  Color get b40;

  /// Dark theme color with index 50.
  Color get b50;

  /// Dark theme color with index 60.
  Color get b60;

  /// Dark theme color with index 70.
  Color get b70;

  /// Returns a primary color.
  Color operator [](int index) {
    switch (index) {
      case 30:
        return b30;
      case 40:
        return b40;
      case 50:
        return b50;
      case 60:
        return b60;
      case 70:
        return b70;
      default:
        throw Exception('Wrong index for primary color');
    }
  }

  /// Returns the color with difference in lightness.
  Color get color => this[50];

  @override
  int get hashCode => Object.hash(name, b30, b40, b50, b60, b70);

  @override
  bool operator ==(covariant PrimaryColor other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other.name == name &&
        other.b30 == b30 &&
        other.b40 == b40 &&
        other.b50 == b50 &&
        other.b60 == b60 &&
        other.b70 == b70;
  }

  @override
  String toString() => name.toString();
}

class _CoralPrimaryColor extends PrimaryColor {
  const _CoralPrimaryColor() : super(name: 'Coral');

  @override
  Color get b30 => const Color(0xff992900);

  @override
  Color get b40 => const Color(0xffcc3600);

  @override
  Color get b50 => const Color(0xffff4400);

  @override
  Color get b60 => const Color(0xffff6933);

  @override
  Color get b70 => const Color(0xffff8f66);
}

class _CornflowerBluePrimaryColor extends PrimaryColor {
  const _CornflowerBluePrimaryColor() : super(name: 'Cornflower Blue');

  @override
  Color get b30 => const Color(0xff103a89);

  @override
  Color get b40 => const Color(0xff154eb7);

  @override
  Color get b50 => const Color(0xff1b61e4);

  @override
  Color get b60 => const Color(0xff4881ea);

  @override
  Color get b70 => const Color(0xff76a0ef);
}

class _TurquoisePrimaryColor extends PrimaryColor {
  const _TurquoisePrimaryColor() : super(name: 'Turquoise');

  @override
  Color get b30 => const Color(0xff0f888a);

  @override
  Color get b40 => const Color(0xff14b5b8);

  @override
  Color get b50 => const Color(0xff19e2e6);

  @override
  Color get b60 => const Color(0xff47e8eb);

  @override
  Color get b70 => const Color(0xff75eef0);
}

class _DeepSkyBluePrimaryColor extends PrimaryColor {
  const _DeepSkyBluePrimaryColor() : super(name: 'Deep Sky Blue');

  @override
  Color get b30 => const Color(0xff007399);

  @override
  Color get b40 => const Color(0xff0099cc);

  @override
  Color get b50 => const Color(0xff00bfff);

  @override
  Color get b60 => const Color(0xff33ccff);

  @override
  Color get b70 => const Color(0xff66d9ff);
}

class _DodgerBluePrimaryColor extends PrimaryColor {
  const _DodgerBluePrimaryColor() : super(name: 'Dodger Blue');

  @override
  Color get b30 => const Color(0xff084d91);

  @override
  Color get b40 => const Color(0xff0a66c2);

  @override
  Color get b50 => const Color(0xff0d80f2);

  @override
  Color get b60 => const Color(0xff3d99f5);

  @override
  Color get b70 => const Color(0xff6eb3f7);
}

class _GoldenrodPrimaryColor extends PrimaryColor {
  const _GoldenrodPrimaryColor() : super(name: 'Goldenrod');

  @override
  Color get b30 => const Color(0xff856514);

  @override
  Color get b40 => const Color(0xffb1871b);

  @override
  Color get b50 => const Color(0xffdea821);

  @override
  Color get b60 => const Color(0xffe4ba4e);

  @override
  Color get b70 => const Color(0xffebcb7a);
}

class _HotPinkPrimaryColor extends PrimaryColor {
  const _HotPinkPrimaryColor() : super(name: 'Hot Pink');

  @override
  Color get b30 => const Color(0xff99004d);

  @override
  Color get b40 => const Color(0xffcc0066);

  @override
  Color get b50 => const Color(0xffff0080);

  @override
  Color get b60 => const Color(0xffff3399);

  @override
  Color get b70 => const Color(0xffff66b3);
}

class _PurplePrimaryColor extends PrimaryColor {
  const _PurplePrimaryColor() : super(name: 'Purple');

  @override
  Color get b30 => const Color(0xff3d1f7a);

  @override
  Color get b40 => const Color(0xff5229a3);

  @override
  Color get b50 => const Color(0xff6633cc);

  @override
  Color get b60 => const Color(0xff855cd6);

  @override
  Color get b70 => const Color(0xffa385e0);
}

class _OrangePrimaryColor extends PrimaryColor {
  const _OrangePrimaryColor() : super(name: 'Orange');

  @override
  Color get b30 => const Color(0xff995400);

  @override
  Color get b40 => const Color(0xffcc7000);

  @override
  Color get b50 => const Color(0xffff8c00);

  @override
  Color get b60 => const Color(0xffffa333);

  @override
  Color get b70 => const Color(0xffffba66);
}

class _RoyalBluePrimaryColor extends PrimaryColor {
  const _RoyalBluePrimaryColor() : super(name: 'Royal Blue');

  @override
  Color get b30 => const Color(0xff153184);

  @override
  Color get b40 => const Color(0xff1c41b0);

  @override
  Color get b50 => const Color(0xff2251dd);

  @override
  Color get b60 => const Color(0xff4f74e3);

  @override
  Color get b70 => const Color(0xff7b97ea);
}

class _SandyBrownPrimaryColor extends PrimaryColor {
  const _SandyBrownPrimaryColor() : super(name: 'Sandy Brown');

  @override
  Color get b30 => const Color(0xff8f360a);

  @override
  Color get b40 => const Color(0xffbf480d);

  @override
  Color get b50 => const Color(0xffee5b11);

  @override
  Color get b60 => const Color(0xfff27b40);

  @override
  Color get b70 => const Color(0xfff59c70);
}

class _SlateBluePrimaryColor extends PrimaryColor {
  const _SlateBluePrimaryColor() : super(name: 'Slate Blue');

  @override
  Color get b30 => const Color(0xff2f2475);

  @override
  Color get b40 => const Color(0xff3e309c);

  @override
  Color get b50 => const Color(0xff4e3cc3);

  @override
  Color get b60 => const Color(0xff7163cf);

  @override
  Color get b70 => const Color(0xff958adb);
}

// class _SteelBluePrimaryColor extends PrimaryColor {
//   const _SteelBluePrimaryColor() : super(name: 'Steel Blue');

//   @override
//   Color get b30 => const Color(0x);

//   @override
//   Color get b40 => const Color(0x);

//   @override
//   Color get b50 => const Color(0x);

//   @override
//   Color get b60 => const Color(0x);

//   @override
//   Color get b70 => const Color(0x);
// }

class _VioletPrimaryColor extends PrimaryColor {
  const _VioletPrimaryColor() : super(name: 'Violet');

  @override
  Color get b30 => const Color(0xff871287);

  @override
  Color get b40 => const Color(0xffb418b4);

  @override
  Color get b50 => const Color(0xffe01fe0);

  @override
  Color get b60 => const Color(0xffe74be7);

  @override
  Color get b70 => const Color(0xffed78ed);
}

class _SpringGreenPrimaryColor extends PrimaryColor {
  const _SpringGreenPrimaryColor() : super(name: 'Spring Green');

  @override
  Color get b30 => const Color(0xff0f8a4d);

  @override
  Color get b40 => const Color(0xff14b866);

  @override
  Color get b50 => const Color(0xff19e680);

  @override
  Color get b60 => const Color(0xff47eb99);

  @override
  Color get b70 => const Color(0xff75f0b3);
}

class _RedPrimaryColor extends PrimaryColor {
  const _RedPrimaryColor() : super(name: 'Red');

  @override
  Color get b30 => const Color(0xff910825);

  @override
  Color get b40 => const Color(0xffc20a32);

  @override
  Color get b50 => const Color(0xfff20d3e);

  @override
  Color get b60 => const Color(0xfff53d65);

  @override
  Color get b70 => const Color(0xfff76e8b);
}

/// Constants for [PrimaryColor].
enum PrimaryColors {
  /// Coral color.
  coral(_CoralPrimaryColor()),

  /// Cornflower blue color.
  cornflowerBlue(_CornflowerBluePrimaryColor()),

  /// Turquoise color.
  turquoise(_TurquoisePrimaryColor()),

  /// Deep sky blue color.
  deepSkyBlue(_DeepSkyBluePrimaryColor()),

  /// Dodger blue color.
  dodgerBlue(_DodgerBluePrimaryColor()),

  /// Goldenrod color.
  goldenrod(_GoldenrodPrimaryColor()),

  /// Hot pink color.
  hotPink(_HotPinkPrimaryColor()),

  /// Purple color.
  purple(_PurplePrimaryColor()),

  /// Orange color.
  orange(_OrangePrimaryColor()),

  /// Royal blue color.
  royalBlue(_RoyalBluePrimaryColor()),

  /// Sandy brown color.
  sandyBrown(_SandyBrownPrimaryColor()),

  /// Slate blue color.
  slateBlue(_SlateBluePrimaryColor()),

  // /// Steel blue color.
  // steelBlue(_SteelBluePrimaryColor()),

  /// Violet color.
  violet(_VioletPrimaryColor()),

  /// Spring green color.
  springGreen(_SpringGreenPrimaryColor()),

  /// Red color.
  red(_RedPrimaryColor());

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
      // } else if (primaryColor == PrimaryColors.steelBlue._primaryColor) {
      //   return PrimaryColors.steelBlue;
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

class Colors {
  static const Color aliceBlue = Color(0xfff0f8ff);
  static const Color antiqueWhite = Color(0xfffaebd7);
  static const Color aqua = Color(0xff00ffff);
  static const Color aquamarine = Color(0xff7fffd4);
  static const Color azure = Color(0xfff0ffff);
  static const Color beige = Color(0xfff5f5dc);
  static const Color bisque = Color(0xffffe4c4);
  static const Color black = Color(0xff000000);
  static const Color blanchedAlmond = Color(0xffffebcd);
  static const Color blue = Color(0xff0000ff);
  static const Color blueViolet = Color(0xff8a2be2);
  static const Color brown = Color(0xffa52a2a);
  static const Color burlyWood = Color(0xffdeb887);
  static const Color cadetBlue = Color(0xff5f9ea0);
  static const Color chartreuse = Color(0xff7fff00);
  static const Color chocolate = Color(0xffd2691e);
  static const Color coral = Color(0xffff7f50);
  static const Color cornflowerBlue = Color(0xff6495ed);
  static const Color cornsilk = Color(0xfffff8dc);
  static const Color crimson = Color(0xffdc143c);
  static const Color cyan = Color(0xff00ffff);
  static const Color darkBlue = Color(0xff00008b);
  static const Color darkCyan = Color(0xff008b8b);
  static const Color darkGoldenrod = Color(0xffb8860b);
  static const Color darkGray = Color(0xffa9a9a9);
  static const Color darkGreen = Color(0xff006400);
  static const Color darkKhaki = Color(0xffbdb76b);
  static const Color darkMagenta = Color(0xff8b008b);
  static const Color darkOliveGreen = Color(0xff556b2f);
  static const Color darkOrange = Color(0xffff8c00);
  static const Color darkOrchid = Color(0xff9932cc);
  static const Color darkRed = Color(0xff8b0000);
  static const Color darkSalmon = Color(0xffe9967a);
  static const Color darkSeaGreen = Color(0xff8fbc8f);
  static const Color darkSlateBlue = Color(0xff483d8b);
  static const Color darkSlateGray = Color(0xff2f4f4f);
  static const Color darkTurquoise = Color(0xff00ced1);
  static const Color darkViolet = Color(0xff9400d3);
  static const Color deepPink = Color(0xffff1493);
  static const Color deepSkyBlue = Color(0xff00bfff);
  static const Color dimGray = Color(0xff696969);
  static const Color dodgerBlue = Color(0xff1e90ff);
  static const Color firebrick = Color(0xffb22222);
  static const Color floralWhite = Color(0xfffffaf0);
  static const Color forestGreen = Color(0xff228b22);
  static const Color fuchsia = Color(0xffff00ff);
  static const Color gainsboro = Color(0xffdcdcdc);
  static const Color ghostWhite = Color(0xfff8f8ff);
  static const Color gold = Color(0xffffd700);
  static const Color goldenrod = Color(0xffdaa520);
  static const Color gray = Color(0xff808080);
  static const Color green = Color(0xff008000);
  static const Color greenYellow = Color(0xffadff2f);
  static const Color honeydew = Color(0xfff0fff0);
  static const Color hotPink = Color(0xffff69b4);
  static const Color indianRed = Color(0xffcd5c5c);
  static const Color indigo = Color(0xff4b0082);
  static const Color ivory = Color(0xfffffff0);
  static const Color khaki = Color(0xfff0e68c);
  static const Color lavender = Color(0xffe6e6fa);
  static const Color lavenderBlush = Color(0xfffff0f5);
  static const Color lawnGreen = Color(0xff7cfc00);
  static const Color lemonChiffon = Color(0xfffffacd);
  static const Color lightBlue = Color(0xffadd8e6);
  static const Color lightCoral = Color(0xfff08080);
  static const Color lightCyan = Color(0xffe0ffff);
  static const Color lightGoldenrodYellow = Color(0xfffafad2);
  static const Color lightGray = Color(0xffd3d3d3);
  static const Color lightGreen = Color(0xff90ee90);
  static const Color lightPink = Color(0xffffb6c1);
  static const Color lightSalmon = Color(0xffffa07a);
  static const Color lightSeaGreen = Color(0xff20b2aa);
  static const Color lightSkyBlue = Color(0xff87cefa);
  static const Color lightSlateGray = Color(0xff778899);
  static const Color lightSteelBlue = Color(0xffb0c4de);
  static const Color lightYellow = Color(0xffffffe0);
  static const Color lime = Color(0xff00ff00);
  static const Color limeGreen = Color(0xff32cd32);
  static const Color linen = Color(0xfffaf0e6);
  static const Color magenta = Color(0xffff00ff);
  static const Color maroon = Color(0xff800000);
  static const Color mediumAquamarine = Color(0xff66cdaa);
  static const Color mediumBlue = Color(0xff0000cd);
  static const Color mediumOrchid = Color(0xffba55d3);
  static const Color mediumPurple = Color(0xff9370db);
  static const Color mediumSeaGreen = Color(0xff3cb371);
  static const Color mediumSlateBlue = Color(0xff7b68ee);
  static const Color mediumSpringGreen = Color(0xff00fa9a);
  static const Color mediumTurquoise = Color(0xff48d1cc);
  static const Color mediumVioletRed = Color(0xffc71585);
  static const Color midnightBlue = Color(0xff191970);
  static const Color mintCream = Color(0xfff5fffa);
  static const Color mistyRose = Color(0xffffe4e1);
  static const Color moccasin = Color(0xffffe4b5);
  static const Color navajoWhite = Color(0xffffdead);
  static const Color navy = Color(0xff000080);
  static const Color oldLace = Color(0xfffdf5e6);
  static const Color olive = Color(0xff808000);
  static const Color oliveDrab = Color(0xff6b8e23);
  static const Color orange = Color(0xffffa500);
  static const Color orangeRed = Color(0xffff4500);
  static const Color orchid = Color(0xffda70d6);
  static const Color paleGoldenrod = Color(0xffeee8aa);
  static const Color paleGreen = Color(0xff98fb98);
  static const Color paleTurquoise = Color(0xffafeeee);
  static const Color paleVioletRed = Color(0xffdb7093);
  static const Color papayaWhip = Color(0xffffefd5);
  static const Color peachPuff = Color(0xffffdab9);
  static const Color peru = Color(0xffcd853f);
  static const Color pink = Color(0xffffc0cb);
  static const Color plum = Color(0xffdda0dd);
  static const Color powderBlue = Color(0xffb0e0e6);
  static const Color purple = Color(0xff800080);
  static const Color red = Color(0xffff0000);
  static const Color rosyBrown = Color(0xffbc8f8f);
  static const Color royalBlue = Color(0xff4169e1);
  static const Color saddleBrown = Color(0xff8b4513);
  static const Color salmon = Color(0xfffa8072);
  static const Color sandyBrown = Color(0xfff4a460);
  static const Color seaGreen = Color(0xff2e8b57);
  static const Color seaShell = Color(0xfffff5ee);
  static const Color sienna = Color(0xffa0522d);
  static const Color silver = Color(0xffc0c0c0);
  static const Color skyBlue = Color(0xff87ceeb);
  static const Color slateBlue = Color(0xff6a5acd);
  static const Color slateGray = Color(0xff708090);
  static const Color snow = Color(0xfffffafa);
  static const Color springGreen = Color(0xff00ff7f);
  static const Color steelBlue = Color(0xff4682b4);
  static const Color tan = Color(0xffd2b48c);
  static const Color teal = Color(0xff008080);
  static const Color thistle = Color(0xffd8bfd8);
  static const Color tomato = Color(0xffff6347);
  static const Color transparent = Color(0x00ffffff);
  static const Color turquoise = Color(0xff40e0d0);
  static const Color violet = Color(0xffee82ee);
  static const Color wheat = Color(0xfff5deb3);
  static const Color white = Color(0xffffffff);
  static const Color whiteSmoke = Color(0xfff5f5f5);
  static const Color yellow = Color(0xffffff00);
  static const Color yellowGreen = Color(0xff9acd32);
}
