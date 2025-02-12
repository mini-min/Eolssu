import SwiftUI

struct CreatingView: View {
    
    private let rhythms = RhythmType.allCases
    
    @State private var bpm: Int = 100
    @State private var droppedRhythms: [RhythmType] = [
        .dung, .kung, .deok,         // Beat 1
        .gideok, .deoreo, .rest,     // Beat 2
        .dung, .dung, .dung,         // Beat 3
        .dung, .dung, .dung          // Beat 4
    ]
    @State private var isPlaying: Bool = false
    @State private var currentBeatIndex: Int = 0
    @State private var isTargeted: Bool = false
    
    var body: some View {
        HStack {
            
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
            .frame(width: 300)
            .background(Color.eolssuBackground)
            .cornerRadius(20)
            
            
            VStack {
                JungGanBoView(
                    rhythmList: $droppedRhythms,
                    jangdanBeat: .constant(4),
                    jangdanSobak: .constant(3)
                )
                .frame(height: 80)
                .padding()
                
                
                VStack(spacing: 50) {
                    ForEach(0..<4, id: \.self) { beatIndex in
                        ZStack {
                            Rectangle()
                                .stroke(Color.eolssuBrown, lineWidth: 5)
                                .background(Color.white)
                            
                            HStack(spacing: 0) {
                                ForEach(0..<3, id: \.self) { sobakIndex in
                                    let rhythmIndex = beatIndex * 3 + sobakIndex
                                    
                                    Rectangle()
                                        .stroke(Color.eolssuBrown.opacity(0.6), style: StrokeStyle(lineWidth: 2, dash: [3, 5]))
                                        .overlay(
                                            droppedRhythms[rhythmIndex].letterImage
                                        )
                                        .dropDestination(for: RhythmType.self) { items, location in
                                            guard let droppedItem = items.first else { return false }
                                            droppedRhythms[rhythmIndex] = droppedItem
                                            return true
                                        }
                                }
                            }
                        }
                    }
                }
                
                CreatingControlView(
                    bpm: $bpm,
                    droppedRhythms: $droppedRhythms,
                    isPlaying: $isPlaying,
                    currentBeatIndex: $currentBeatIndex
                )
            }
            .background(Color.eolssuBackground)
            .cornerRadius(20)
        }
    }
}

#Preview {
    CreatingView()
}
