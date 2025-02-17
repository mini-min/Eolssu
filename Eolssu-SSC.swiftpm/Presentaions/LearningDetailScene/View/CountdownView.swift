import SwiftUI

struct CountdownView: View {
    var countdownValue: Int
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("\(countdownValue)")
                    .font(.myFont(size: 200))
                    .foregroundColor(.white)
                    .transition(.opacity.combined(with: .scale)) 
                
                Text("Playback will start shortly.\nListen to the Jang-Dan once, then practice playing on. repeat this five times to master it!")
                    .font(.myFont(size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(20)
            }
        }
    }
}

#Preview {
    CountdownView(countdownValue: 3)
}
