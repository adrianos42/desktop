// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Desktop",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Desktop",
            targets: ["Desktop"]
        ),
    ],
    targets: [
        .target(
            name: "Desktop",
            path: "Sources/Desktop"
        ),
        .testTarget(
            name: "DesktopTests",
            dependencies: ["Desktop"],
            path: "Tests/DesktopTests"
        ),
    ]
)
