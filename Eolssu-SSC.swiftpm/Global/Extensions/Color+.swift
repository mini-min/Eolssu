import SwiftUI

extension Color {
    static let eolssuPink = Color(hex: "#FA8E73")
    static let eolssuBrown = Color(hex: "#B17C5D")
    static let eolssuDarkBrown = Color(hex: "#4B3527")
    static let eolssuBackground = Color(hex: "#F9F5EA")
    static let eolssuGray1 = Color(hex: "#E9ECEF")
    static let eolssuGray2 = Color(hex: "#A8ACB3")
    static let eolssuGray3 = Color(hex: "#666C76")
    static let eolssuGray4 = Color(hex: "#2B2D31")
    static let eolssuBlack = Color(hex: "#2E2E2E")
    
    // for Introduce Jang-Dan
    static let veryFastText = Color(hex: "#B7382F")
    static let veryFastBack = Color(hex: "#FB8D75")
    static let fastBack = Color(hex: "#FFDED7")
    static let slightlyFastText = Color(hex: "#F5934E")
    static let slightlyFastBack = Color(hex: "#FFE1CC")
    static let moderateText = Color(hex: "#F0B759")
    static let moderateBack = Color(hex: "#FFE8C1")
    static let slowText = Color(hex: "#34C759")
    static let slowBack = Color(hex: "#ECFFDA")
    static let rhythmBack = Color(hex: "#F0DCBB")
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
