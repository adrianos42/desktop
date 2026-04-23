import Foundation

#if canImport(SwiftUI)
import SwiftUI

extension View {
    /// Attaches a tooltip to this view, mirroring the Flutter `Tooltip`
    /// widget. On platforms that don't support hover-based tooltips
    /// (e.g. iOS), this is a no-op.
    @ViewBuilder
    public func desktopTooltip(_ message: String?) -> some View {
        _desktopTooltip(message)
    }

    /// Internal helper used by widgets in the framework.
    @ViewBuilder
    func _desktopTooltip(_ message: String?) -> some View {
        if let message = message, !message.isEmpty {
            #if os(macOS)
            self.help(message)
            #else
            self
            #endif
        } else {
            self
        }
    }
}
#endif
