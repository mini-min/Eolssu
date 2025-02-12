import SwiftUI

enum RhythmType: String, CaseIterable, Codable, Transferable {
    
    case dung = "Dung"
    case kung = "Kung"
    case deok = "Deok"
    case gideok = "Gideok"
    case deoreo = "Deoreoreoreo"
    case rest = ""
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .plainText)
    }
    
    var letterImage: Image {
        switch self {
        case .dung: Image(ImageName.dungLetter.rawValue)
        case .kung: Image(ImageName.kungLetter.rawValue)
        case .deok: Image(ImageName.deokLetter.rawValue)
        case .gideok: Image(ImageName.gideokLetter.rawValue)
        case .deoreo: Image(ImageName.deoreoLetter.rawValue)
        case .rest: Image("eolssu_rest")
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
    
    var description: String {
        switch self {
        case .dung:
            return "Deep and powerful sound made by striking both drumheads simultaneously."
        case .kung: 
            return "Low and soft sound made by hitting left side."
        case .deok: 
            return "Bright and soft sound made by hitting right side."
        case .gideok:
            return "Quick double hit on right side, sounding like “Deok-Deok.”"
        case .deoreo: 
            return "Rapid rolling or trilling sound created by continuously striking right side."
        case .rest: 
            return ""
        }
    }
    
    var sound: String {
        switch self {
        case .dung: SoundName.dung.rawValue
        case .kung: SoundName.kung.rawValue
        case .deok: SoundName.deok.rawValue
        case .gideok: SoundName.gideok.rawValue
        case .deoreo: SoundName.deoreo.rawValue
        case .rest: SoundName.rest.rawValue
        }
    }
}
