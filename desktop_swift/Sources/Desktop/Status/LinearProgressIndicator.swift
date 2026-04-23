import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed linear progress indicator, mirroring the Flutter
/// `LinearProgressIndicator`.
///
/// If `value` is `nil`, the indicator is indeterminate.
public struct LinearProgressIndicator: View {
    @Environment(\.desktopTheme) private var theme

    private let value: Double?
    private let height: CGFloat

    public init(value: Double? = nil, height: CGFloat = 2) {
        self.value = value
        self.height = height
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(theme.colorScheme.background[12])
                if let value = value {
                    Rectangle()
                        .fill(theme.colorScheme.primary[50])
                        .frame(width: max(0, min(1, value)) * proxy.size.width)
                } else {
                    IndeterminateBar(color: theme.colorScheme.primary[50],
                                     totalWidth: proxy.size.width)
                }
            }
        }
        .frame(height: height)
        .clipped()
    }
}

private struct IndeterminateBar: View {
    let color: Color
    let totalWidth: CGFloat
    @State private var phase: CGFloat = -0.4

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: max(0, totalWidth * 0.4))
            .offset(x: phase * totalWidth)
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 1.0
                }
            }
    }
}
#endif
