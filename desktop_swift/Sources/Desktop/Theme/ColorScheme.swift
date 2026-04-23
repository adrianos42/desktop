import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// Shade color used in ``ColorScheme``.
///
/// Mirrors the Flutter `ShadeColor` abstract class. Provides an `index`-based
/// lookup that uses the configured ``Brightness`` to pick between the
/// `w`-prefixed (light theme) and `b`-prefixed (dark theme) variants.
public struct ShadeColor: Equatable {
    public let brightness: Brightness

    public let w30, w40, w50, w60, w70, w80, w90, w100: Color
    public let b30, b40, b50, b60, b70, b80, b90, b100: Color

    public init(
        brightness: Brightness = .dark,
        w30: Color = Color(hexARGB: 0xffa1a1a1),
        w40: Color = Color(hexARGB: 0xff8a8a8a),
        w50: Color = Color(hexARGB: 0xff737373),
        w60: Color = Color(hexARGB: 0xff5c5c5c),
        w70: Color = Color(hexARGB: 0xff454545),
        w80: Color = Color(hexARGB: 0xff2e2e2e),
        w90: Color = Color(hexARGB: 0xff171717),
        w100: Color = Color(hexARGB: 0xff000000),
        b30: Color = Color(hexARGB: 0xff5e5e5e),
        b40: Color = Color(hexARGB: 0xff757575),
        b50: Color = Color(hexARGB: 0xff8c8c8c),
        b60: Color = Color(hexARGB: 0xffa3a3a3),
        b70: Color = Color(hexARGB: 0xffbababa),
        b80: Color = Color(hexARGB: 0xffd1d1d1),
        b90: Color = Color(hexARGB: 0xffe8e8e8),
        b100: Color = Color(hexARGB: 0xffffffff)
    ) {
        self.brightness = brightness
        self.w30 = w30; self.w40 = w40; self.w50 = w50; self.w60 = w60
        self.w70 = w70; self.w80 = w80; self.w90 = w90; self.w100 = w100
        self.b30 = b30; self.b40 = b40; self.b50 = b50; self.b60 = b60
        self.b70 = b70; self.b80 = b80; self.b90 = b90; self.b100 = b100
    }

    /// Returns a copy of this shade with the given ``Brightness``.
    public func withBrightness(_ brightness: Brightness) -> ShadeColor {
        ShadeColor(
            brightness: brightness,
            w30: w30, w40: w40, w50: w50, w60: w60,
            w70: w70, w80: w80, w90: w90, w100: w100,
            b30: b30, b40: b40, b50: b50, b60: b60,
            b70: b70, b80: b80, b90: b90, b100: b100
        )
    }

    /// Returns the shade for the given index. Valid indices are
    /// `30`, `40`, `50`, `60`, `70`, `80`, `90`, `100`.
    public subscript(index: Int) -> Color {
        switch (brightness, index) {
        case (.light, 30): return w30
        case (.light, 40): return w40
        case (.light, 50): return w50
        case (.light, 60): return w60
        case (.light, 70): return w70
        case (.light, 80): return w80
        case (.light, 90): return w90
        case (.light, 100): return w100
        case (.dark, 30): return b30
        case (.dark, 40): return b40
        case (.dark, 50): return b50
        case (.dark, 60): return b60
        case (.dark, 70): return b70
        case (.dark, 80): return b80
        case (.dark, 90): return b90
        case (.dark, 100): return b100
        default:
            assertionFailure("Wrong index for shade color: \(index)")
            return brightness == .dark ? b50 : w50
        }
    }
}

/// Background color used in ``ColorScheme``.
public struct BackgroundColor: Equatable {
    public let brightness: Brightness
    public let w0, w4, w8, w12, w16, w20: Color
    public let b0, b4, b8, b12, b16, b20: Color

    public init(
        brightness: Brightness = .dark,
        w0: Color = Color(hexARGB: 0xffffffff),
        w4: Color = Color(hexARGB: 0xfff5f5f5),
        w8: Color = Color(hexARGB: 0xffebebeb),
        w12: Color = Color(hexARGB: 0xffe0e0e0),
        w16: Color = Color(hexARGB: 0xffd6d6d6),
        w20: Color = Color(hexARGB: 0xffcccccc),
        b0: Color = Color(hexARGB: 0xff000000),
        b4: Color = Color(hexARGB: 0xff0a0a0a),
        b8: Color = Color(hexARGB: 0xff141414),
        b12: Color = Color(hexARGB: 0xff1f1f1f),
        b16: Color = Color(hexARGB: 0xff292929),
        b20: Color = Color(hexARGB: 0xff333333)
    ) {
        self.brightness = brightness
        self.w0 = w0; self.w4 = w4; self.w8 = w8
        self.w12 = w12; self.w16 = w16; self.w20 = w20
        self.b0 = b0; self.b4 = b4; self.b8 = b8
        self.b12 = b12; self.b16 = b16; self.b20 = b20
    }

    /// Returns a copy of this background color with the given ``Brightness``.
    public func withBrightness(_ brightness: Brightness) -> BackgroundColor {
        BackgroundColor(
            brightness: brightness,
            w0: w0, w4: w4, w8: w8, w12: w12, w16: w16, w20: w20,
            b0: b0, b4: b4, b8: b8, b12: b12, b16: b16, b20: b20
        )
    }

    /// Returns the background for the given index. Valid indices are
    /// `0`, `4`, `8`, `12`, `16`, `20`.
    public subscript(index: Int) -> Color {
        switch (brightness, index) {
        case (.light, 0): return w0
        case (.light, 4): return w4
        case (.light, 8): return w8
        case (.light, 12): return w12
        case (.light, 16): return w16
        case (.light, 20): return w20
        case (.dark, 0): return b0
        case (.dark, 4): return b4
        case (.dark, 8): return b8
        case (.dark, 12): return b12
        case (.dark, 16): return b16
        case (.dark, 20): return b20
        default:
            assertionFailure("Wrong index for background color: \(index)")
            return brightness == .dark ? b0 : w0
        }
    }
}

/// Color scheme used by ``ThemeData``.
///
/// Mirrors the Flutter `ColorScheme` class. Holds the ``PrimaryColor``,
/// ``ShadeColor``, ``BackgroundColor``, disabled and error colors.
public struct ColorScheme: Equatable {
    public let primary: AnyPrimaryColor
    public let background: BackgroundColor
    public let shade: ShadeColor
    public let disabled: Color
    public let error: Color

    public init(
        primary: AnyPrimaryColor? = nil,
        background: BackgroundColor? = nil,
        shade: ShadeColor? = nil,
        disabled: Color = Color(hexARGB: 0xff404040),
        error: Color = Color(hexARGB: 0xffd74242)
    ) {
        self.primary = primary ?? PrimaryColors.dodgerBlue.primaryColor
        self.background = background ?? BackgroundColor()
        self.shade = shade ?? ShadeColor()
        self.disabled = disabled
        self.error = error
    }
}
#endif
