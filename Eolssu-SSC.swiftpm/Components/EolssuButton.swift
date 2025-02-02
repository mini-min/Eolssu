import SwiftUI

struct EolssuButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.myFont(size: 20)) 
            .foregroundColor(.white)
            .padding()
            .background(Color.eolssuBrown)
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
