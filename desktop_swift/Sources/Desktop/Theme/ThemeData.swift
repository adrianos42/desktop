import Foundation

#if canImport(SwiftUI)
import SwiftUI

/// Top-level theme container.
///
/// Mirrors the Flutter `ThemeData` class. Holds the ``ColorScheme`` and
/// the overall ``Brightness`` for the desktop UI.
public struct ThemeData: Equatable {
    public let brightness: Brightness
    public let colorScheme: ColorScheme

    /// Convenience access to the primary color from the ``ColorScheme``.
    public var primaryColor: AnyPrimaryColor { colorScheme.primary }

    public init(
        brightness: Brightness = .dark,
        primaryColor: AnyPrimaryColor? = nil,
        colorScheme: ColorScheme? = nil
    ) {
        self.brightness = brightness
        if let colorScheme = colorScheme {
            self.colorScheme = colorScheme
        } else {
            let resolvedPrimary = primaryColor ?? PrimaryColors.dodgerBlue.primaryColor
            self.colorScheme = ColorScheme(
                primary: resolvedPrimary,
                background: BackgroundColor(brightness: brightness)
                    .withBrightness(brightness),
                shade: ShadeColor(brightness: brightness)
                    .withBrightness(brightness)
            )
        }
    }

    /// The default background color for the theme.
    public var backgroundColor: Color { colorScheme.background[0] }

    /// The default text color for the theme.
    public var textColor: Color { colorScheme.shade[100] }
}

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: ThemeData = ThemeData()
}

extension EnvironmentValues {
    /// The current ``ThemeData`` provided by ``DesktopApp`` or
    /// ``View/desktopTheme(_:)``.
    public var desktopTheme: ThemeData {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

extension View {
    /// Injects a ``ThemeData`` into the SwiftUI environment.
    public func desktopTheme(_ theme: ThemeData) -> some View {
        environment(\.desktopTheme, theme)
            .preferredColorScheme(theme.brightness == .dark ? .dark : .light)
    }
}

/// Convenience accessor for the current ``ThemeData``, mirroring the Flutter
/// `Theme.of(context)` pattern.
public enum Theme {
    /// Returns the current ``ThemeData`` from the SwiftUI environment.
    @ViewBuilder
    public static func of<Content: View>(@ViewBuilder _ build: @escaping (ThemeData) -> Content) -> some View {
        ThemeReader(build: build)
    }
}

private struct ThemeReader<Content: View>: View {
    @Environment(\.desktopTheme) private var theme
    let build: (ThemeData) -> Content

    var body: some View {
        build(theme)
    }
}
#endif
