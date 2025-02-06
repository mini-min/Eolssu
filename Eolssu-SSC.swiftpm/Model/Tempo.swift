import SwiftUI

enum Tempo: String {
    case veryFast = "Very Fast Tempo"
    case fast = "Fast Tempo"
    case slightlyFast = "Slightly Fast Tempo"
    case moderate = "Moderate Tempo"
    case slow = "Slow Tempo"
    
    var backColor: Color {
        switch self {
        case .veryFast: .veryFastBack
        case .fast: .fastBack
        case .slightlyFast: .slightlyFastBack
        case .moderate: .moderateBack
        case .slow: .slowBack
        }
    }
    
    var textColor: Color {
        switch self {
        case .veryFast: .veryFastText
        case .fast: .eolssuPink
        case .slightlyFast: .slightlyFastText
        case .moderate: .moderateText
        case .slow: .slowText
        }
    }
}
