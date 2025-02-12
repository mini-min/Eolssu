import SwiftUI

struct RhythmListView: View {
    let rhythms: [RhythmType]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rhythms")
                .font(.myFont(size: 32))
                .foregroundStyle(Color.eolssuBrown)
                .padding(.bottom, 10)
                .padding([.top, .leading], 25)
            
            Text("Drag Korean letters to make\nyour own cool korean rhythm!")
                .font(.myFont(size: 16))
                .foregroundStyle(Color.eolssuBrown)
                .padding(.leading, 25)
                .padding(.bottom, 30)
            
            ForEach(rhythms.dropLast(), id: \.self) { rhythm in
                HStack(spacing: 25) {
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
        .frame(width: 330)
        .background(Color.eolssuBackground)
        .cornerRadius(20)
    }
}
