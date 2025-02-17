import SwiftUI

struct BeatView: View {
    let beatIndex: Int
    @Binding var droppedRhythms: [RhythmType]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Beat \(beatIndex+1)")
                .font(.myFont(size: 32))
                .foregroundStyle(Color.eolssuBrown.opacity(0.5))
            
            ZStack {
                Rectangle()
                    .stroke(Color.eolssuBrown, lineWidth: 5)
                    .background(Color.white)
                
                HStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { sobakIndex in
                        let rhythmIndex = beatIndex * 3 + sobakIndex
                        SobakView(rhythm: $droppedRhythms[rhythmIndex])
                    }
                }
            }
        }
    }
}

#Preview {
    BeatView(
        beatIndex: 0,
        droppedRhythms: .constant(JangDanType.jajinmori.rhythms))
}
