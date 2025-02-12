import SwiftUI

struct CreatingView: View {
    private let rhythms = RhythmType.allCases
    
    @State private var droppedRhythms: [RhythmType] = [
        .rest, .rest, .rest,         // Beat 1
        .rest, .rest, .rest,         // Beat 2
        .rest, .rest, .rest,         // Beat 3
        .rest, .rest, .rest          // Beat 4
    ]
    @State private var bpm: Int = 100
    @State private var isPlaying: Bool = false
    @State private var currentBeatIndex: Int = 0
    
    var body: some View {
        HStack {
            RhythmListView(rhythms: rhythms)
            
            VStack(spacing: 30) {
                JungGanBoView(
                    rhythmList: $droppedRhythms,
                    jangdanBeat: .constant(4),
                    jangdanSobak: .constant(3),
                    isPlaying: $isPlaying,
                    currentBeatIndex: $currentBeatIndex
                )
                .frame(height: 80)
                .padding()
                
                
                VStack(alignment: .center) {
                    VStack(spacing: 0) {
                        ForEach(0..<2, id: \.self) { outIndex in
                            HStack() {
                                ForEach(0..<2, id: \.self) { innerIndex in
                                    let beatIndex = outIndex * 2 + innerIndex
                                    
                                    BeatView(
                                        beatIndex: beatIndex, 
                                        droppedRhythms: $droppedRhythms
                                    )
                                    .padding(30)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    CreatingControlView(
                        bpm: $bpm,
                        droppedRhythms: $droppedRhythms,
                        isPlaying: $isPlaying,
                        currentBeatIndex: $currentBeatIndex
                    )
                    .padding(20)
                }
                .background(Color.eolssuBackground)
                .cornerRadius(20)
                .padding()
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: resetDroppedRhythms) {
                    Label("Reset", systemImage: "arrow.trianglehead.2.clockwise")
                        .labelStyle(.titleAndIcon)
                        .font(.myFont(size: 20))
                        .foregroundColor(.eolssuBrown)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
            }
        }
    }
}

extension CreatingView {
    func resetDroppedRhythms() {
        droppedRhythms = Array(repeating: .rest, count: droppedRhythms.count)
        SoundManager.shared.playSound(name: SoundName.eolssu.rawValue)
    }
}

#Preview {
    CreatingView()
}
