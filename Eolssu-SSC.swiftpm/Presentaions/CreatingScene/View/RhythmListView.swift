import SwiftUI

struct RhythmListView: View {
    let rhythms: [RhythmType]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Rhythms")
                .font(.myFont(size: 32))
                .foregroundStyle(Color.eolssuBrown)
                .padding([.top, .leading], 25)
                .padding(.bottom, 10)
            
            Text("Drag Korean letters to make\nyour own cool korean rhythm!")
                .font(.myFont(size: 16))
                .foregroundStyle(Color.eolssuBrown)
                .lineSpacing(10)
                .padding(.leading, 25)
                .padding(.bottom, 20)
            
            ForEach(rhythms.dropLast(), id: \.self) { rhythm in
                HStack(spacing: 20) {
                    rhythm.letterImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                        .draggable(rhythm)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(rhythm.rawValue)
                                .font(.myFont(size: 24))
                                .foregroundStyle(Color.eolssuBlack)
                            
                            Button(action: {
                                SoundManager.shared.playSound(name: rhythm.sound)
                            }, label: {
                                Image(systemName: "speaker.wave.2")
                                    .foregroundColor(.eolssuBrown)
                            })
                        }
                        
                        Text(rhythm.description)
                            .font(.myFont(size: 12))
                            .foregroundStyle(Color.eolssuGray3)
                    }
                }
                .padding()
            }
        }
        .frame(width: 320)
        .background(Color.eolssuBackground)
        .cornerRadius(20)
    }
}

#Preview {
    RhythmListView(rhythms: RhythmType.allCases)
}
