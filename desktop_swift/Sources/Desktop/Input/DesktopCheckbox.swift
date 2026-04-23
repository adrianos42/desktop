import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed checkbox, mirroring the Flutter `Checkbox` widget.
///
/// Supports an optional tri-state (`nil` = indeterminate).
public struct DesktopCheckbox: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var value: Bool?
    @State private var isHovering = false
    private let tristate: Bool
    private let onChanged: ((Bool?) -> Void)?

    public init(value: Binding<Bool?>, tristate: Bool = false,
                onChanged: ((Bool?) -> Void)? = nil) {
        self._value = value
        self.tristate = tristate
        self.onChanged = onChanged
    }

    public init(value: Binding<Bool>, onChanged: ((Bool) -> Void)? = nil) {
        self._value = Binding<Bool?>(
            get: { value.wrappedValue },
            set: { value.wrappedValue = $0 ?? false }
        )
        self.tristate = false
        self.onChanged = onChanged.map { cb in
            { newValue in cb(newValue ?? false) }
        }
    }

    public var body: some View {
        Button(action: toggle) {
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .strokeBorder(borderColor, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 2).fill(fillColor))
                    .frame(width: 16, height: 16)
                if value == true {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(theme.colorScheme.shade[100])
                } else if value == nil {
                    Rectangle()
                        .fill(theme.colorScheme.shade[100])
                        .frame(width: 8, height: 2)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .onHover { isHovering = $0 }
    }

    private func toggle() {
        let newValue: Bool?
        if tristate {
            switch value {
            case .some(false): newValue = true
            case .some(true): newValue = nil
            case .none: newValue = false
            }
        } else {
            newValue = !(value ?? false)
        }
        value = newValue
        onChanged?(newValue)
    }

    private var fillColor: Color {
        let scheme = theme.colorScheme
        guard isEnabled else { return scheme.disabled.opacity(0.3) }
        if value == true || value == nil {
            return isHovering ? scheme.primary[60] : scheme.primary[50]
        }
        return .clear
    }

    private var borderColor: Color {
        let scheme = theme.colorScheme
        guard isEnabled else { return scheme.disabled }
        if value == true || value == nil {
            return isHovering ? scheme.primary[60] : scheme.primary[50]
        }
        return isHovering ? scheme.shade[70] : scheme.shade[50]
    }
}
#endif
