import SwiftUI

enum Score {
    case perfect, good, oops
    
    var backgroundColor: Color {
        switch self {
        case .perfect: return Color.eolssuPink
        case .good: return Color.moderateText
        case .oops: return Color.eolssuGray2
        }
    }
    
    var description: String {
        switch self {
        case .perfect: 
            return "Perfect! It's a great Jang-Dan!"
        case .good: 
            return "Good Job. You were very close to the perfect beat!"
        case .oops: 
            return "Oops! Stay calm and get ready for the next rhythm."
        }
    }
}
