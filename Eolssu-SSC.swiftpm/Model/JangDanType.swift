import SwiftUI

enum JangDanType: CaseIterable {
    case jajinmori, semachi, gutgeori, jungjungmori, hwimori, eotmori
    
    var korTitle: String {
        switch self {
        case .jajinmori: return "자진모리"
        case .semachi: return "세마치"
        case .gutgeori: return "굿거리"
        case .jungjungmori: return "중중모리"
        case .hwimori: return "휘모리"
        case .eotmori: return "엇모리"
        }
    }
    
    var engTitle: String {
        switch self {
        case .jajinmori: return "Jajinmori"
        case .semachi: return "Semachi"
        case .gutgeori: return "Gutgeori"
        case .jungjungmori: return "Jungjungmori"
        case .hwimori: return "Hwimori"
        case .eotmori: return "Eotmori"
        }
    }
    
    var description: [String] {
        switch self {
        case .jajinmori:
            return [
                "Jajinmori means fast dirven rhythm.",
                "fast-paced 12-beat rhythm, known for its lively and dynamic energy."
            ]
        case .semachi:
            return [
                "Semachi means three-beat structured rhythm.",
                "This rhythm is written in a 9/8 time signature, with a light and cheerful feeling."
            ]
        case .gutgeori: 
            return [
                "Gutgeori means rhythm used when shamanistic rituals (gut), invite spirits.",
                "tempo with a 12/8 time signature, widely used in folk songs, dance music."
            ]
        case .jungjungmori:
            return [
                "Jungjungmori means moderately fast rhythm.",
                "Conveys excitement or emotional intensity and is often used in both vocal and instrumental music."
            ]
        case .hwimori: 
            return [
                "Hwimori means whirlwind rhythm, indicating its extremely fast tempo.",
                "It is used for climactic or highly dynamic scenes, creating a sense of urgency or excitement."
            ]
        case .eotmori: 
            return [
                "Eotmori means irregular rotation, reflecting its unique beat structure.",
                "Creates an uneven, dramatic effect and used to introduce special characters or pivotal moments."
            ]
        }
    }
    
    var tempo: Tempo {
        switch self {
        case .jajinmori: return .fast
        case .semachi: return .slightlyFast
        case .gutgeori: return .slow
        case .jungjungmori: return .moderate
        case .hwimori: return .veryFast
        case .eotmori: return .slightlyFast
        }
    }
    
    var level: level {
        switch self {
        case .jajinmori, .semachi:
            return .moderate
        case .gutgeori, .jungjungmori:
            return .easy
        case .hwimori, .eotmori:
            return .challenging
        }
    }
    
    var beat: Int {
        switch self {
        case .jajinmori, .gutgeori, .jungjungmori, .hwimori, .eotmori:
            return 4
        case .semachi:
            return 3
        }
    }
    
    var sobak: Int {
        switch self {
        case .jajinmori, .semachi, .gutgeori, .jungjungmori, .eotmori:
            return 3
        case .hwimori:
            return 2
        }
    }
    
    var rhythms: [RhythmType] {
        switch self {
        case .jajinmori:
            return [
                .dung, .rest, .rest,
                .kung, .rest, .rest,
                .kung, .rest, .deok,
                .kung, .rest, .rest
            ]
        case .semachi:
            return [
                .dung, .rest, .rest,
                .dung, .rest, .deok,
                .kung, .deok, .rest
            ]
        case .gutgeori:
            return [
                .dung, .rest, .gideok,
                .kung, .deoreo, .rest,
                .kung, .rest, .gideok,
                .kung, .deoreo, .rest
            ]
        case .jungjungmori:
            return [
                .dung, .rest, .deok,
                .kung, .deok, .deok,
                .kung, .kung, .deok,
                .kung, .rest, .kung
            ]
        case .hwimori:
            return [
                .dung, .rest,
                .deok, .deok,
                .kung, .deok,
                .kung, .rest
            ]
        case .eotmori:
            return [
                .dung, .rest, .deok,
                .kung, .kung,
                .kung, .rest, .deok,
                .kung, .rest
            ]
        }
    }
}
