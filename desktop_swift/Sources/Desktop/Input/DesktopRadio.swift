import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed radio button, mirroring the Flutter `Radio` widget.
public struct DesktopRadio<Value: Hashable>: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var groupValue: Value?
    @State private var isHovering = false
    private let value: Value
    private let onChanged: ((Value) -> Void)?

    public init(value: Value, groupValue: Binding<Value?>,
                onChanged: ((Value) -> Void)? = nil) {
        self.value = value
        self._groupValue = groupValue
        self.onChanged = onChanged
    }

    public var body: some View {
        Button(action: select) {
            ZStack {
                Circle()
                    .strokeBorder(borderColor, lineWidth: 1)
                    .frame(width: 16, height: 16)
                if isSelected {
                    Circle()
                        .fill(borderColor)
                        .frame(width: 8, height: 8)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .onHover { isHovering = $0 }
    }

    private var isSelected: Bool { groupValue == value }

    private func select() {
        groupValue = value
        onChanged?(value)
    }

    private var borderColor: Color {
        let scheme = theme.colorScheme
        guard isEnabled else { return scheme.disabled }
        if isSelected {
            return isHovering ? scheme.primary[60] : scheme.primary[50]
        }
        return isHovering ? scheme.shade[70] : scheme.shade[50]
    }
}
#endif
