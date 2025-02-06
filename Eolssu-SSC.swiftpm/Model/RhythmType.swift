import SwiftUI

enum RhythmType {
    case dung, kung, deok, gideok, deoreo, rest
    
    var letterImage: Image {
        switch self {
        case .dung: Image(ImageName.dungLetter.rawValue)
        case .kung: Image(ImageName.kungLetter.rawValue)
        case .deok: Image(ImageName.deokLetter.rawValue)
        case .gideok: Image(ImageName.gideokLetter.rawValue)
        case .deoreo: Image(ImageName.deoreoLetter.rawValue)
        case .rest: Image("")
        }
    }
    
    var iconImage: Image {
        switch self {
        case .dung: Image(ImageName.dungIcon.rawValue)
        case .kung: Image(ImageName.kungIcon.rawValue)
        case .deok: Image(ImageName.deokIcon.rawValue)
        case .gideok: Image(ImageName.gideokIcon.rawValue)
        case .deoreo: Image(ImageName.deoreoIcon.rawValue)
        case .rest: Image("")
        }
    }
    
//    var description: String {
//        switch self {
//        case .dung:
//        case .kung: Image(ImageName.kungIcon.rawValue)
//        case .deok: Image(ImageName.deokIcon.rawValue)
//        case .gideok: Image(ImageName.gideokIcon.rawValue)
//        case .deoreo: Image(ImageName.deoreoIcon.rawValue)
//        }
//    }
}
