import SwiftUI

extension Color {
    static let eolssuPink = Color(hex: "#FA8E73")
    static let eolssuBrown = Color(hex: "B17C5D")
    static let eolssuBackground = Color(hex: "F9F5EA")
    static let eolssuGray1 = Color(hex: "E9ECEF")
    static let eolssuGray2 = Color(hex: "A8ACB3")
    static let eolssuGray3 = Color(hex: "666C76")
    static let eolssuGray4 = Color(hex: "2B2D31")
    static let eolssuBlack = Color(hex: "2E2E2E")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
