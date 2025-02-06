import SwiftUI

enum level: String {
    case challenging = "Challenging🔥"
    case moderate = "Moderate💪"
    case easy = "Easy🌱"
    
    var backColor: Color {
        switch self {
        case .challenging: .fastBack
        case .moderate: .moderateBack
        case .easy: .slowBack
        }
    }
    
    var textColor: Color {
        switch self {
        case .challenging: .eolssuPink
        case .moderate: .moderateText
        case .easy: .slowText
        }
    }
}
