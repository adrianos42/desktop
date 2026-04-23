import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// The root view of a desktop app, mirroring the Flutter `DesktopApp`.
///
/// `DesktopApp` injects a ``ThemeData`` into the SwiftUI environment and
/// applies the appropriate background color so that descendant views can
/// resolve theme colors via `@Environment(\.desktopTheme)`.
public struct DesktopApp<Content: View>: View {
    private let theme: ThemeData
    private let content: Content

    public init(theme: ThemeData = ThemeData(), @ViewBuilder content: () -> Content) {
        self.theme = theme
        self.content = content()
    }

    public var body: some View {
        content
            .foregroundColor(theme.textColor)
            .background(theme.backgroundColor.ignoresSafeArea())
            .desktopTheme(theme)
    }
}
#endif
