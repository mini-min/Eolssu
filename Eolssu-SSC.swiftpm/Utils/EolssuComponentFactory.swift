import SwiftUI

protocol EolssuComponentFactoryProtocol {
    associatedtype Component: View
    
    func makeEolssuButton(title: String, action: @escaping () -> Void) -> Component
}

struct EolssuComponentFactory: EolssuComponentFactoryProtocol {
    
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
