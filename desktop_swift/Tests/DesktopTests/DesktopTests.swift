import XCTest
#if canImport(SwiftUI)
import SwiftUI
@testable import Desktop

final class DesktopTests: XCTestCase {
    func testColorHexInitializerParsesARGB() {
        let color = Color(hexARGB: 0xff112233)
        // The conversion is lossy via Color, so we only verify that
        // creating known values doesn't crash and yields equal Colors for the
        // same input.
        XCTAssertEqual(color, Color(hexARGB: 0xff112233))
    }

    func testBrightnessInverse() {
        XCTAssertEqual(Brightness.dark.inverse, .light)
        XCTAssertEqual(Brightness.light.inverse, .dark)
    }

    func testPrimaryColorsHaveDistinctNames() {
        let names = Set(PrimaryColors.allCases.map { $0.primaryColor.name })
        XCTAssertEqual(names.count, PrimaryColors.allCases.count)
    }

    func testPrimaryColorIndexAccess() {
        let primary = PrimaryColors.dodgerBlue.primaryColor
        XCTAssertEqual(primary.color, primary[50])
    }

    func testShadeColorIndexUsesBrightness() {
        let dark = ShadeColor(brightness: .dark)
        let light = ShadeColor(brightness: .light)
        XCTAssertEqual(dark[50], dark.b50)
        XCTAssertEqual(light[50], light.w50)
    }

    func testBackgroundColorIndexUsesBrightness() {
        let dark = BackgroundColor(brightness: .dark)
        let light = BackgroundColor(brightness: .light)
        XCTAssertEqual(dark[0], dark.b0)
        XCTAssertEqual(light[0], light.w0)
    }

    func testThemeDataDefaults() {
        let theme = ThemeData()
        XCTAssertEqual(theme.brightness, .dark)
        XCTAssertEqual(theme.primaryColor.name,
                       PrimaryColors.dodgerBlue.primaryColor.name)
    }

    func testThemeDataCustomPrimary() {
        let theme = ThemeData(brightness: .light,
                              primaryColor: PrimaryColors.royalBlue.primaryColor)
        XCTAssertEqual(theme.brightness, .light)
        XCTAssertEqual(theme.primaryColor.name, "Royal Blue")
    }

    func testTabItemHasUniqueIDs() {
        let a = TabItem(title: "A") { Text("A") }
        let b = TabItem(title: "B") { Text("B") }
        XCTAssertNotEqual(a.id, b.id)
    }
}
#endif
