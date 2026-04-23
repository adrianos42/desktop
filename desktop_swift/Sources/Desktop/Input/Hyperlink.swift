import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A text hyperlink, mirroring the Flutter `Hyperlink` widget.
public struct Hyperlink: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @State private var isHovering = false

    private let title: String
    private let onPressed: (() -> Void)?

    public init(_ title: String, onPressed: (() -> Void)?) {
        self.title = title
        self.onPressed = onPressed
    }

    public var body: some View {
        Button(action: { onPressed?() }) {
            Text(title)
                .underline(isHovering)
                .foregroundColor(color)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(onPressed == nil || !isEnabled)
        .onHover { isHovering = $0 }
    }

    private var color: Color {
        let scheme = theme.colorScheme
        guard isEnabled, onPressed != nil else { return scheme.disabled }
        return isHovering ? scheme.primary[60] : scheme.primary[50]
    }
}
#endif
