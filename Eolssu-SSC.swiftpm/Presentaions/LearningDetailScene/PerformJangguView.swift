import SwiftUI

struct PerformJangguView: View {
    var body: some View {
        ZStack {
            Color.white
            
            Image.janggu3
                .resizable()
                .scaledToFit()
            
        }
        .cornerRadius(20)
    }
}

#Preview {
    PerformJangguView()
}
