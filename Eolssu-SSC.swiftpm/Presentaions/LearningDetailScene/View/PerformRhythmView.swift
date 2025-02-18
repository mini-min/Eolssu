import SwiftUI

struct PerformRhythmView: View {    
    @Binding var repeatValue: Int
    @Binding var currentRhythm: RhythmType
        
    var body: some View {
        ZStack {
            Image(ImageName.janggu3.rawValue)
            
            HStack(alignment: .bottom, spacing: 40) {
                ForEach(RhythmType.allCases.dropLast(), id: \.self) { rhythm in
                    
                    VStack {
                        Button(action: {
                            SoundManager.shared.playSound(name: rhythm.sound)
                        }) {
                            if repeatValue % 2 != 0 {
                                rhythm.letterButtonImage
                                    .renderingMode(.template)
                                    .foregroundColor(.eolssuGray2)
                                    .contentShape(Rectangle())
                            } else {
                                rhythm.letterButtonImage
                                    .contentShape(Rectangle())
                            }
                        }
                        .disabled(repeatValue % 2 != 0)
                        .padding(.vertical, 50)
                        
                        Text("Tap!")
                            .font(.myFont(size: 32))
                            .foregroundStyle(Color.eolssuPink)
                            .opacity(repeatValue % 2 == 0 && repeatValue < 6 && currentRhythm == rhythm ? 1 : 0)
                            .animation(.easeInOut(duration: 0.3), value: repeatValue)
                    }
                }
            }
            .padding(.horizontal, 50)
        }
    }
}

#Preview {
    PerformRhythmView(repeatValue: .constant(0), currentRhythm: .constant(.dung))
}
