import SwiftUI

struct EolssuText: View {
    var originalText: String
    var targetText: String
    var targetColor: Color
    
    var body: some View {
        if let coloredRange = originalText.range(of: targetText) {
            let beforeRange = originalText[..<coloredRange.lowerBound]
            let coloredText = originalText[coloredRange]
            let afterRange = originalText[coloredRange.upperBound...]
            
            return Text(beforeRange).foregroundColor(.eolssuBlack)
            + Text(coloredText).foregroundColor(targetColor)
            + Text(afterRange).foregroundColor(.eolssuBlack)
        }
        
        return Text(originalText).foregroundColor(.eolssuBlack)
    }
}
