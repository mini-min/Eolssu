import SwiftUI

final class EolssuComponentFactory {
    
    static let shared = EolssuComponentFactory()
    private init() {}
    
    func makeEollsuText(
        _ orignialText: String,
        _ targetText: String,
        with color: Color
    ) -> some View {
        return EolssuText(originalText: orignialText, targetText: targetText, targetColor: color)
    }
    
    
    func makeEolssuButton(
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(EolssuButton())
    }
}
