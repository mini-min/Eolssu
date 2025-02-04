import SwiftUI

struct LearningCard: View {
    var text: String
    
    var body: some View {
        ZStack {
            Color.eolssuBrown
            
            Text(text)
        }
    }
}

#Preview {
    LearningCard(text: "어쩌구")
}
