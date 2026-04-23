import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// A themed circular progress indicator, mirroring the Flutter
/// `CircularProgressIndicator`.
///
/// If `value` is `nil`, the indicator spins continuously.
public struct CircularProgressIndicator: View {
    @Environment(\.desktopTheme) private var theme

    private let value: Double?
    private let size: CGFloat
    private let lineWidth: CGFloat

    @State private var rotation: Double = 0

    public init(value: Double? = nil, size: CGFloat = 24, lineWidth: CGFloat = 3) {
        self.value = value
        self.size = size
        self.lineWidth = lineWidth
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(theme.colorScheme.background[12], lineWidth: lineWidth)
            if let value = value {
                Circle()
                    .trim(from: 0, to: max(0, min(1, value)))
                    .stroke(theme.colorScheme.primary[50],
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            } else {
                Circle()
                    .trim(from: 0, to: 0.25)
                    .stroke(theme.colorScheme.primary[50],
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                    }
            }
        }
        .frame(width: size, height: size)
    }
}
#endif
