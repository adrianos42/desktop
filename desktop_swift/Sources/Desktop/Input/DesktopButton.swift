import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed button, mirroring the Flutter `Button` widget.
///
/// This is an initial port. It supports a leading view, a body view, a
/// trailing view, an optional tooltip, the `filled` style and an `active`
/// state.
public struct DesktopButton<Leading: View, Body_: View, Trailing: View>: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @State private var isHovering = false
    @State private var isPressed = false

    private let leading: Leading
    private let bodyContent: Body_
    private let trailing: Trailing
    private let tooltip: String?
    private let filled: Bool
    private let active: Bool?
    private let onPressed: (() -> Void)?

    public init(
        tooltip: String? = nil,
        filled: Bool = false,
        active: Bool? = nil,
        onPressed: (() -> Void)?,
        @ViewBuilder leading: () -> Leading = { EmptyView() },
        @ViewBuilder body: () -> Body_,
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.tooltip = tooltip
        self.filled = filled
        self.active = active
        self.onPressed = onPressed
        self.leading = leading()
        self.bodyContent = body()
        self.trailing = trailing()
    }

    public var body: some View {
        Button(action: { onPressed?() }) {
            HStack(spacing: 8) {
                leading
                bodyContent
                trailing
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minHeight: 28)
            .background(background)
            .foregroundColor(foreground)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(onPressed == nil || !isEnabled)
        .onHover { isHovering = $0 }
        ._desktopTooltip(tooltip)
    }

    private var isInteractive: Bool { onPressed != nil && isEnabled }

    private var background: Color {
        let scheme = theme.colorScheme
        if !isInteractive {
            return filled ? scheme.disabled.opacity(0.4) : .clear
        }
        if active == true {
            return scheme.primary[40]
        }
        if filled {
            return isHovering ? scheme.primary[60] : scheme.primary[50]
        }
        return isHovering ? scheme.background[12] : .clear
    }

    private var foreground: Color {
        let scheme = theme.colorScheme
        if !isInteractive {
            return scheme.disabled
        }
        if filled {
            return scheme.shade[100]
        }
        return isHovering ? scheme.primary[60] : scheme.shade[80]
    }
}

extension DesktopButton where Leading == EmptyView, Trailing == EmptyView, Body_ == Text {
    /// Convenience initializer for a text-only button.
    public init(_ title: String,
                tooltip: String? = nil,
                filled: Bool = false,
                active: Bool? = nil,
                onPressed: (() -> Void)?) {
        self.init(tooltip: tooltip, filled: filled, active: active, onPressed: onPressed,
                  leading: { EmptyView() },
                  body: { Text(title) },
                  trailing: { EmptyView() })
    }
}
#endif
