import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed text field, mirroring the Flutter `TextField` widget.
public struct DesktopTextField: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var text: String
    private let placeholder: String
    private let onChanged: ((String) -> Void)?

    public init(text: Binding<String>,
                placeholder: String = "",
                onChanged: ((String) -> Void)? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.onChanged = onChanged
    }

    public var body: some View {
        TextField(placeholder, text: Binding(
            get: { text },
            set: { newValue in
                text = newValue
                onChanged?(newValue)
            }
        ))
        .textFieldStyle(.plain)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .foregroundColor(theme.colorScheme.shade[100])
        .background(
            Rectangle()
                .fill(theme.colorScheme.background[4])
        )
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isEnabled ? theme.colorScheme.shade[50]
                                           : theme.colorScheme.disabled),
            alignment: .bottom
        )
        .disabled(!isEnabled)
    }
}
#endif
