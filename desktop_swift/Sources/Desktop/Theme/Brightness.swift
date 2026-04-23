import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// The brightness of the theme, mirroring `dart:ui`'s `Brightness`.
public enum Brightness: Equatable, Hashable, Sendable {
    case light
    case dark

    /// Returns the opposite brightness.
    public var inverse: Brightness {
        switch self {
        case .light: return .dark
        case .dark: return .light
        }
    }
}
#endif
