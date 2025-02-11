import SwiftUI

enum ImageName: String {
    case main = "eolssu_main_logo"
    
    // Image Assets
    case rotate = "img_rotate"
    case janggu = "img_janggu"
    case janggu2 = "img_janggu2"
    case janggu3 = "img_janggu3"
    case guideLeft = "img_guide_left"
    case guideRight = "img_guide_right"
    case guideBoth = "img_guide_both"
    
    // Icon Assets
    case list = "icn_go_to_list"
    
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
    case deoreoIcon = "eolssu_deoreo_icon_color"
}

extension Image {
    static let main = Image(ImageName.main.rawValue)
    
    static let rotate = Image(ImageName.rotate.rawValue)
    static let janggu = Image(ImageName.janggu.rawValue)
    static let janggu2 = Image(ImageName.janggu2.rawValue)
    static let janggu3 = Image(ImageName.janggu3.rawValue)
    static let guideLeft = Image(ImageName.guideLeft.rawValue)
    static let guideRight = Image(ImageName.guideRight.rawValue)
    static let guideBoth = Image(ImageName.guideBoth.rawValue)
    
    static let list = Image(ImageName.list.rawValue)
}
