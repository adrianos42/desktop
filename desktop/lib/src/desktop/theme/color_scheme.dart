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
  const ColorScheme(
    this.brightness, {
    PrimaryColor? primary,
    BackgroundColor? backgroundColor,
    ShadeColor? shade,
  })  : _primary = primary ?? _kDefaultPrimary,
        _shade = shade ?? _kDefaultShadeColor,
        _background = backgroundColor ?? _backgroundColor;

  /// Returns a color scheme with a different brightness.
  ColorScheme withBrightness(Brightness brightness) {
    return ColorScheme(brightness, primary: _primary);
  }

  /// The color scheme brightness.
  final Brightness brightness;

  final ShadeColor _shade;
  final PrimaryColor _primary;
  final BackgroundColor _background;

  /// Shade color.
  ShadeColor get shade => _shade.withBrightness(brightness);

  /// Primary color.
  PrimaryColor get primary => _primary.withBrightness(brightness);

  /// Background color.
  BackgroundColor get background => _background.withBrightness(brightness);

  /// Disabled color.
  Color get disabled => brightness == Brightness.light
      ? const Color(0xffbfbfbf)
      : const Color(0xff404040);

  /// Error color.
  Color get error => brightness == Brightness.light
      ? const Color(0xfff20d0d)
      : const Color(0xffd74242);
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
      default:
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
      default:
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
    this.brightness = Brightness.dark,
    required this.name,
  });

  /// The [Brightness] of the primary color.
  final Brightness brightness;

  /// Used by [ColorScheme] to return a color with current brightness.
  PrimaryColor withBrightness(Brightness brightness);

  /// The name of the primary color.
  final String name;

  /// Light theme color with index 30.
  Color get w30;

  /// Light theme color with index 40.
  Color get w40;

  /// Light theme color with index 50.
  Color get w50;

  /// Light theme color with index 60.
  Color get w60;

  /// Light theme color with index 70.
  Color get w70;

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
          default:
            throw Exception('Wrong index for primary color');
        }
      case Brightness.dark:
      default:
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
  }

  /// Returns the color with difference in lightness.
  Color get color => this[50];

  @override
  int get hashCode => Object.hash(
        name,
        w30,
        w40,
        w50,
        w60,
        w70,
        b30,
        b40,
        b50,
        b60,
        b70,
      );

  @override
  bool operator ==(covariant PrimaryColor other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other.name == name &&
        other.w30 == w30 &&
        other.w40 == w40 &&
        other.w50 == w50 &&
        other.w60 == w60 &&
        other.w70 == w70 &&
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
  const _CoralPrimaryColor({super.brightness}) : super(name: 'Coral');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _CoralPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xffff8f66);

  @override
  Color get w40 => const Color(0xffff6933);

  @override
  Color get w50 => const Color(0xffff4400);

  @override
  Color get w60 => const Color(0xffcc3600);

  @override
  Color get w70 => const Color(0xff992900);

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
  const _CornflowerBluePrimaryColor({super.brightness})
      : super(name: 'Cornflower Blue');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _CornflowerBluePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff76a0ef);

  @override
  Color get w40 => const Color(0xff4881ea);

  @override
  Color get w50 => const Color(0xff1b61e4);

  @override
  Color get w60 => const Color(0xff154eb7);

  @override
  Color get w70 => const Color(0xff103a89);

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
  const _TurquoisePrimaryColor({super.brightness}) : super(name: 'Turquoise');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _TurquoisePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff75eef0);

  @override
  Color get w40 => const Color(0xff47e8eb);

  @override
  Color get w50 => const Color(0xff19e2e6);

  @override
  Color get w60 => const Color(0xff14b5b8);

  @override
  Color get w70 => const Color(0xff0f888a);

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
  const _DeepSkyBluePrimaryColor({super.brightness})
      : super(name: 'Deep Sky Blue');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _DeepSkyBluePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff66d9ff);

  @override
  Color get w40 => const Color(0xff33ccff);

  @override
  Color get w50 => const Color(0xff00bfff);

  @override
  Color get w60 => const Color(0xff0099cc);

  @override
  Color get w70 => const Color(0xff007399);

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
  const _DodgerBluePrimaryColor({super.brightness})
      : super(name: 'Dodger Blue');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _DodgerBluePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff6eb3f7);

  @override
  Color get w40 => const Color(0xff3d99f5);

  @override
  Color get w50 => const Color(0xff0d80f2);

  @override
  Color get w60 => const Color(0xff0a66c2);

  @override
  Color get w70 => const Color(0xff084d91);

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
  const _GoldenrodPrimaryColor({super.brightness}) : super(name: 'Goldenrod');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _GoldenrodPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xffebcb7a);

  @override
  Color get w40 => const Color(0xffe4ba4e);

  @override
  Color get w50 => const Color(0xffdea821);

  @override
  Color get w60 => const Color(0xffb1871b);

  @override
  Color get w70 => const Color(0xff856514);

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
  const _HotPinkPrimaryColor({super.brightness}) : super(name: 'Hot Pink');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _HotPinkPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xffff66b3);

  @override
  Color get w40 => const Color(0xffff3399);

  @override
  Color get w50 => const Color(0xffff0080);

  @override
  Color get w60 => const Color(0xffcc0066);

  @override
  Color get w70 => const Color(0xff99004d);

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
  const _PurplePrimaryColor({super.brightness}) : super(name: 'Purple');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _PurplePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xffa385e0);

  @override
  Color get w40 => const Color(0xff855cd6);

  @override
  Color get w50 => const Color(0xff6633cc);

  @override
  Color get w60 => const Color(0xff5229a3);

  @override
  Color get w70 => const Color(0xff3d1f7a);

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
  const _OrangePrimaryColor({super.brightness}) : super(name: 'Orange');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _OrangePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xffffba66);

  @override
  Color get w40 => const Color(0xffffa333);

  @override
  Color get w50 => const Color(0xffff8c00);

  @override
  Color get w60 => const Color(0xffcc7000);

  @override
  Color get w70 => const Color(0xff995400);

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
  const _RoyalBluePrimaryColor({super.brightness}) : super(name: 'Royal Blue');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _RoyalBluePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff7b97ea);

  @override
  Color get w40 => const Color(0xff4f74e3);

  @override
  Color get w50 => const Color(0xff2251dd);

  @override
  Color get w60 => const Color(0xff1c41b0);

  @override
  Color get w70 => const Color(0xff153184);

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
  const _SandyBrownPrimaryColor({super.brightness})
      : super(name: 'Sandy Brown');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _SandyBrownPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xfff59c70);

  @override
  Color get w40 => const Color(0xfff27b40);

  @override
  Color get w50 => const Color(0xffee5b11);

  @override
  Color get w60 => const Color(0xffbf480d);

  @override
  Color get w70 => const Color(0xff8f360a);

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
  const _SlateBluePrimaryColor({super.brightness}) : super(name: 'Slate Blue');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _SlateBluePrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff958adb);

  @override
  Color get w40 => const Color(0xff7163cf);

  @override
  Color get w50 => const Color(0xff4e3cc3);

  @override
  Color get w60 => const Color(0xff3e309c);

  @override
  Color get w70 => const Color(0xff2f2475);

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
//   const _SteelBluePrimaryColor({super.brightness}) : super(name: 'Steel Blue');

//   @override
//   PrimaryColor withBrightness(Brightness brightness) =>
//       _SteelBluePrimaryColor(brightness: brightness);

//       @override
//   Color get w30 => const Color(0x);

//   @override
//   Color get w40 => const Color(0x);

//   @override
//   Color get w50 => const Color(0x);

//   @override
//   Color get w60 => const Color(0x);

//   @override
//   Color get w70 => const Color(0x);

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
  const _VioletPrimaryColor({super.brightness}) : super(name: 'Violet');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _VioletPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xffed78ed);

  @override
  Color get w40 => const Color(0xffe74be7);

  @override
  Color get w50 => const Color(0xffe01fe0);

  @override
  Color get w60 => const Color(0xffb418b4);

  @override
  Color get w70 => const Color(0xff871287);

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
  const _SpringGreenPrimaryColor({super.brightness})
      : super(name: 'Spring Green');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _SpringGreenPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xff75f0b3);

  @override
  Color get w40 => const Color(0xff47eb99);

  @override
  Color get w50 => const Color(0xff19e680);

  @override
  Color get w60 => const Color(0xff14b866);

  @override
  Color get w70 => const Color(0xff0f8a4d);

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
  const _RedPrimaryColor({super.brightness}) : super(name: 'Red');

  @override
  PrimaryColor withBrightness(Brightness brightness) =>
      _RedPrimaryColor(brightness: brightness);

  @override
  Color get w30 => const Color(0xfff76e8b);

  @override
  Color get w40 => const Color(0xfff53d65);

  @override
  Color get w50 => const Color(0xfff20d3e);

  @override
  Color get w60 => const Color(0xffc20a32);

  @override
  Color get w70 => const Color(0xff910825);

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
