import SwiftUI

enum ImageName: String {
    case main = "eolssu_main_logo"
    
    // Letter Assets
    case dungLetter = "eolssu_dung_color"
    case kungLetter = "eolssu_kung_color"
    case deokLetter = "eolssu_deok_color"
    case gideokLetter = "eolssu_gideok_color"
    case deoreoLetter = "eolssu_deoreo_color"
    
    // icon Assets
    case dungIcon = "eolssu_dung_icon_color"
    case kungIcon = "eolssu_kung_icon_color"
    case deokIcon = "eolssu_deok_icon_color"
    case gideokIcon = "eolssu_gideok_icon_color"
    case deoreoIcon = "eolssu_duoreo_icon_color"
}

extension Image {
    static let main = Image(ImageName.main.rawValue)
}
