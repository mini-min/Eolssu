import SwiftUI

struct EolssuButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.myFont(size: 20)) 
            .foregroundColor(.white)
            .padding()
            .background(Color.eolssuBrown)
            .cornerRadius(15)
    }
}
