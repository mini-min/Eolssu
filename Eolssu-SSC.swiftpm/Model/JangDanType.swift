import SwiftUI

enum JangDanType: CaseIterable {
    case jajinmori
    case semachi
    case gutgeori
    case jungjungmori
    case hwimori
    case eotmori
    
    var title: String {
        switch self {
        case .jajinmori: return "Jajinmori"
        case .semachi: return "Jajinmori"
        case .gutgeori: return "Jajinmori"
        case .jungjungmori: return "Jajinmori"
        case .hwimori: return "Jajinmori"
        case .eotmori: return "Jajinmori"
        }
    }
}
