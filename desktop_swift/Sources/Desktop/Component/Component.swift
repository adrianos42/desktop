import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// Common base for desktop components, mirroring the Flutter
/// `component.dart` helpers.
///
/// At the moment this exposes a small `ComponentState` enum that represents
/// the interactive state of a button-like control.
public enum ComponentState: Equatable {
    case idle
    case hovered
    case pressed
    case focused
    case disabled
}
#endif
