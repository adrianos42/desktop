# Desktop (SwiftUI)

A SwiftUI port of the [`desktop`](../desktop) Flutter package, providing a
minimal set of desktop-style widgets/views for Apple platforms.

This package is an initial implementation that mirrors the structure of the
Flutter library. Components currently included:

* **App**
  * `DesktopApp` – a SwiftUI scene/view modifier that injects the theme.
* **Theme**
  * `ColorScheme`, `PrimaryColor`, `PrimaryColors`, `ShadeColor`,
    `BackgroundColor`, `Brightness`
  * `ThemeData` – top-level theme container.
  * `Theme` / `ThemeEnvironmentKey` – environment-based theme propagation.
* **Input**
  * `DesktopButton`
  * `Hyperlink`
  * `DesktopCheckbox`
  * `ToggleSwitch`
  * `DesktopRadio`
  * `DesktopSlider`
* **Status**
  * `LinearProgressIndicator`
  * `CircularProgressIndicator`
* **Dialogs**
  * `Tooltip` (view modifier)
* **Navigation**
  * `Tab` (basic tab container)
* **Text**
  * `DesktopTextField` (themed wrapper around `TextField`)

## Requirements

* Swift 5.7+
* macOS 12+ / iOS 15+
* Xcode 14+ (SwiftUI is required at build time; Linux is not supported)

## Usage

Add the package as a Swift Package dependency, then:

```swift
import SwiftUI
import Desktop

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            DesktopApp(
                theme: ThemeData(
                    brightness: .dark,
                    primaryColor: PrimaryColors.royalBlue.primaryColor
                )
            ) {
                Tab(items: [
                    TabItem(title: "Home") { Text("Home") },
                    TabItem(title: "Library") { Text("Library") },
                ])
            }
        }
    }
}
```

## Status

This is the **initial** implementation. The API surface is intentionally small
and is expected to evolve to better match the Flutter `desktop` package over
time.

## License

See [LICENSE](../LICENSE).
