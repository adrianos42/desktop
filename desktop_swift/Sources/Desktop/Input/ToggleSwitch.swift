import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed toggle switch, mirroring the Flutter `ToggleSwitch` widget.
public struct ToggleSwitch: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var isOn: Bool
    @State private var isHovering = false
    private let onChanged: ((Bool) -> Void)?

    public init(isOn: Binding<Bool>, onChanged: ((Bool) -> Void)? = nil) {
        self._isOn = isOn
        self.onChanged = onChanged
    }

    public var body: some View {
        Button(action: toggle) {
            ZStack(alignment: isOn ? .trailing : .leading) {
                Capsule()
                    .fill(trackColor)
                    .frame(width: 32, height: 16)
                Circle()
                    .fill(thumbColor)
                    .frame(width: 12, height: 12)
                    .padding(2)
            }
            .animation(.easeInOut(duration: 0.15), value: isOn)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .onHover { isHovering = $0 }
    }

    private func toggle() {
        isOn.toggle()
        onChanged?(isOn)
    }

    private var trackColor: Color {
        let scheme = theme.colorScheme
        guard isEnabled else { return scheme.disabled.opacity(0.4) }
        if isOn {
            return isHovering ? scheme.primary[60] : scheme.primary[50]
        }
        return isHovering ? scheme.shade[70] : scheme.shade[50]
    }

    private var thumbColor: Color {
        isEnabled ? theme.colorScheme.shade[100] : theme.colorScheme.disabled
    }
}
#endif
