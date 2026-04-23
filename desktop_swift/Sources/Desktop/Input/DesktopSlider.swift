import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed slider, mirroring the Flutter `Slider` widget.
public struct DesktopSlider: View {
    @Environment(\.desktopTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var value: Double
    private let range: ClosedRange<Double>
    private let onChanged: ((Double) -> Void)?

    public init(value: Binding<Double>,
                in range: ClosedRange<Double> = 0...1,
                onChanged: ((Double) -> Void)? = nil) {
        self._value = value
        self.range = range
        self.onChanged = onChanged
    }

    public var body: some View {
        // Use SwiftUI's built-in Slider but tint it with the theme's primary
        // color. Future revisions may replace this with a custom drawn track
        // that matches the Flutter visuals more closely.
        Slider(
            value: Binding(
                get: { value },
                set: { newValue in
                    value = newValue
                    onChanged?(newValue)
                }
            ),
            in: range
        )
        .tint(isEnabled ? theme.colorScheme.primary[50] : theme.colorScheme.disabled)
        .disabled(!isEnabled)
    }
}
#endif
