import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// Primary color used in a ``ColorScheme``.
///
/// Mirrors the Flutter `PrimaryColor` abstract class. A primary color exposes
/// five shades indexed by `30`, `40`, `50`, `60`, `70`.
public protocol PrimaryColor: Equatable {
    /// The display name of the primary color.
    var name: String { get }

    /// Dark theme color with index `30`.
    var b30: Color { get }
    /// Dark theme color with index `40`.
    var b40: Color { get }
    /// Dark theme color with index `50`.
    var b50: Color { get }
    /// Dark theme color with index `60`.
    var b60: Color { get }
    /// Dark theme color with index `70`.
    var b70: Color { get }
}

extension PrimaryColor {
    /// Returns the shade for the requested index. Valid indices are
    /// `30`, `40`, `50`, `60`, `70`.
    public subscript(index: Int) -> Color {
        switch index {
        case 30: return b30
        case 40: return b40
        case 50: return b50
        case 60: return b60
        case 70: return b70
        default:
            assertionFailure("Wrong index for primary color: \(index)")
            return b50
        }
    }

    /// The default color for this primary color (index `50`).
    public var color: Color { self[50] }
}

/// A type-erased ``PrimaryColor``.
public struct AnyPrimaryColor: PrimaryColor {
    public let name: String
    public let b30: Color
    public let b40: Color
    public let b50: Color
    public let b60: Color
    public let b70: Color

    public init(name: String, b30: Color, b40: Color, b50: Color, b60: Color, b70: Color) {
        self.name = name
        self.b30 = b30
        self.b40 = b40
        self.b50 = b50
        self.b60 = b60
        self.b70 = b70
    }

    public init<P: PrimaryColor>(_ primary: P) {
        self.name = primary.name
        self.b30 = primary.b30
        self.b40 = primary.b40
        self.b50 = primary.b50
        self.b60 = primary.b60
        self.b70 = primary.b70
    }

    public static func == (lhs: AnyPrimaryColor, rhs: AnyPrimaryColor) -> Bool {
        lhs.name == rhs.name
    }
}

/// Built-in primary colors, mirroring the Flutter `PrimaryColors` enum.
public enum PrimaryColors: String, CaseIterable, Sendable {
    case coral
    case cornflowerBlue
    case turquoise
    case deepSkyBlue
    case dodgerBlue
    case goldenrod
    case hotPink
    case purple
    case orange
    case royalBlue
    case sandyBrown
    case slateBlue
    case violet
    case springGreen
    case red

    /// The associated ``PrimaryColor`` value.
    public var primaryColor: AnyPrimaryColor {
        switch self {
        case .coral:
            return AnyPrimaryColor(name: "Coral",
                                   b30: Color(hexARGB: 0xff992900),
                                   b40: Color(hexARGB: 0xffcc3600),
                                   b50: Color(hexARGB: 0xffff4400),
                                   b60: Color(hexARGB: 0xffff6933),
                                   b70: Color(hexARGB: 0xffff8f66))
        case .cornflowerBlue:
            return AnyPrimaryColor(name: "Cornflower Blue",
                                   b30: Color(hexARGB: 0xff103a89),
                                   b40: Color(hexARGB: 0xff154eb7),
                                   b50: Color(hexARGB: 0xff1b61e4),
                                   b60: Color(hexARGB: 0xff4881ea),
                                   b70: Color(hexARGB: 0xff76a0ef))
        case .turquoise:
            return AnyPrimaryColor(name: "Turquoise",
                                   b30: Color(hexARGB: 0xff0f888a),
                                   b40: Color(hexARGB: 0xff14b5b8),
                                   b50: Color(hexARGB: 0xff19e2e6),
                                   b60: Color(hexARGB: 0xff47e8eb),
                                   b70: Color(hexARGB: 0xff75eef0))
        case .deepSkyBlue:
            return AnyPrimaryColor(name: "Deep Sky Blue",
                                   b30: Color(hexARGB: 0xff007399),
                                   b40: Color(hexARGB: 0xff0099cc),
                                   b50: Color(hexARGB: 0xff00bfff),
                                   b60: Color(hexARGB: 0xff33ccff),
                                   b70: Color(hexARGB: 0xff66d9ff))
        case .dodgerBlue:
            return AnyPrimaryColor(name: "Dodger Blue",
                                   b30: Color(hexARGB: 0xff084d91),
                                   b40: Color(hexARGB: 0xff0a66c2),
                                   b50: Color(hexARGB: 0xff0d80f2),
                                   b60: Color(hexARGB: 0xff3d99f5),
                                   b70: Color(hexARGB: 0xff6eb3f7))
        case .goldenrod:
            return AnyPrimaryColor(name: "Goldenrod",
                                   b30: Color(hexARGB: 0xff856514),
                                   b40: Color(hexARGB: 0xffb1871b),
                                   b50: Color(hexARGB: 0xffdea821),
                                   b60: Color(hexARGB: 0xffe4ba4e),
                                   b70: Color(hexARGB: 0xffebcb7a))
        case .hotPink:
            return AnyPrimaryColor(name: "Hot Pink",
                                   b30: Color(hexARGB: 0xff99004d),
                                   b40: Color(hexARGB: 0xffcc0066),
                                   b50: Color(hexARGB: 0xffff0080),
                                   b60: Color(hexARGB: 0xffff3399),
                                   b70: Color(hexARGB: 0xffff66b3))
        case .purple:
            return AnyPrimaryColor(name: "Purple",
                                   b30: Color(hexARGB: 0xff3d1f7a),
                                   b40: Color(hexARGB: 0xff5229a3),
                                   b50: Color(hexARGB: 0xff6633cc),
                                   b60: Color(hexARGB: 0xff855cd6),
                                   b70: Color(hexARGB: 0xffa385e0))
        case .orange:
            return AnyPrimaryColor(name: "Orange",
                                   b30: Color(hexARGB: 0xff995400),
                                   b40: Color(hexARGB: 0xffcc7000),
                                   b50: Color(hexARGB: 0xffff8c00),
                                   b60: Color(hexARGB: 0xffffa333),
                                   b70: Color(hexARGB: 0xffffba66))
        case .royalBlue:
            return AnyPrimaryColor(name: "Royal Blue",
                                   b30: Color(hexARGB: 0xff153184),
                                   b40: Color(hexARGB: 0xff1c41b0),
                                   b50: Color(hexARGB: 0xff2251dd),
                                   b60: Color(hexARGB: 0xff4f74e3),
                                   b70: Color(hexARGB: 0xff7b97ea))
        case .sandyBrown:
            return AnyPrimaryColor(name: "Sandy Brown",
                                   b30: Color(hexARGB: 0xff8f360a),
                                   b40: Color(hexARGB: 0xffbf480d),
                                   b50: Color(hexARGB: 0xffee5b11),
                                   b60: Color(hexARGB: 0xfff27b40),
                                   b70: Color(hexARGB: 0xfff59c70))
        case .slateBlue:
            return AnyPrimaryColor(name: "Slate Blue",
                                   b30: Color(hexARGB: 0xff2f2475),
                                   b40: Color(hexARGB: 0xff3e309c),
                                   b50: Color(hexARGB: 0xff4e3cc3),
                                   b60: Color(hexARGB: 0xff7163cf),
                                   b70: Color(hexARGB: 0xff958adb))
        case .violet:
            return AnyPrimaryColor(name: "Violet",
                                   b30: Color(hexARGB: 0xff871287),
                                   b40: Color(hexARGB: 0xffb418b4),
                                   b50: Color(hexARGB: 0xffe01fe0),
                                   b60: Color(hexARGB: 0xffe74be7),
                                   b70: Color(hexARGB: 0xffed78ed))
        case .springGreen:
            return AnyPrimaryColor(name: "Spring Green",
                                   b30: Color(hexARGB: 0xff0f8a4d),
                                   b40: Color(hexARGB: 0xff14b866),
                                   b50: Color(hexARGB: 0xff19e680),
                                   b60: Color(hexARGB: 0xff47eb99),
                                   b70: Color(hexARGB: 0xff75f0b3))
        case .red:
            return AnyPrimaryColor(name: "Red",
                                   b30: Color(hexARGB: 0xff910825),
                                   b40: Color(hexARGB: 0xffc20a32),
                                   b50: Color(hexARGB: 0xfff20d3e),
                                   b60: Color(hexARGB: 0xfff53d65),
                                   b70: Color(hexARGB: 0xfff76e8b))
        }
    }
}
#endif
