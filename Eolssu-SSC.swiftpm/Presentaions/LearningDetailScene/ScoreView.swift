import SwiftUI

struct ScoreView: View {
    @Binding var scoreStatus: Score
    
    var body: some View {
        ZStack {
            scoreStatus.backgroundColor.opacity(0.9)
            
            Text(scoreStatus.description)
                .font(.myFont(size: 36))
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    ScoreView(scoreStatus: .constant(.perfect))
}
