import Foundation

#if canImport(SwiftUI)
import SwiftUI

extension Color {
    /// Initializes a `Color` from a 32-bit ARGB hexadecimal value, mirroring
    /// Flutter's `Color(0xAARRGGBB)` constructor.
    public init(hexARGB value: UInt32) {
        let a = Double((value >> 24) & 0xff) / 255.0
        let r = Double((value >> 16) & 0xff) / 255.0
        let g = Double((value >> 8) & 0xff) / 255.0
        let b = Double(value & 0xff) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
#endif
