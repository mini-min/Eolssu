import SwiftUI

struct PerformRhythmView: View {
    @State private var performRhythm: RhythmType = .rest
    @Binding var repeatValue: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 130) {
            ForEach(RhythmType.allCases.dropLast(), id: \.self) { rhythm in
                Button(action: {
                    performRhythm = rhythm
                    SoundManager.shared.playSound(name: rhythm.sound)
                }) {
                    if repeatValue % 2 != 0 {
                        rhythm.letterImage
                            .renderingMode(.template)
                            .foregroundColor(.eolssuGray2)
                            .scaleEffect(1.8)
                            .contentShape(Rectangle())
                    } else {
                        rhythm.letterImage
                            .scaleEffect(1.8)
                            .contentShape(Rectangle())
                    }
                }
                .disabled(repeatValue % 2 != 0)
            }
        }
    }
}

#Preview {
    PerformRhythmView(repeatValue: .constant(0))
}
