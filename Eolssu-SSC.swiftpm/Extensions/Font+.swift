import SwiftUI

enum FontName: String {
    case goverment = "Government_16040911"
}

extension Font {    
    static func myFont(size: CGFloat) -> Font {
        return .custom(FontName.goverment.rawValue, size: size)
    }
}

extension UIFont {
    @nonobjc class func myFont(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.goverment.rawValue, size: size)!
    }
}
