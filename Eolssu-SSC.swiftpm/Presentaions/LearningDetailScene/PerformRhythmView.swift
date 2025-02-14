import SwiftUI

struct PerformRhythmView: View {    
    @Binding var repeatValue: Int
    @Binding var currentRhythm: RhythmType
        
    var body: some View {
        ZStack {
            Image.janggu3
            
            HStack(alignment: .bottom, spacing: 130) {
                ForEach(RhythmType.allCases.dropLast(), id: \.self) { rhythm in
                    
                    VStack {
                        Button(action: {
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
                        .padding(.bottom, 80)
                        
                        Text("Tap!")
                            .font(.myFont(size: 32))
                            .foregroundStyle(Color.eolssuPink)
                            .opacity(repeatValue % 2 == 0 && currentRhythm == rhythm ? 1 : 0)
                    }
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    PerformRhythmView(repeatValue: .constant(0), currentRhythm: .constant(.dung))
}
