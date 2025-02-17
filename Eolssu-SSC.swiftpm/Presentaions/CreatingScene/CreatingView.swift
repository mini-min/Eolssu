import SwiftUI

struct CreatingView: View {
    private let rhythms = RhythmType.allCases
    
    @State private var bpm: Int = 100
    @State private var isPlaying: Bool = false
    @State private var isRepeating: Bool = false
    @State private var currentBeatIndex: Int = 0
    @State private var droppedRhythms: [RhythmType] = [
        .rest, .rest, .rest,         // Beat 1
        .rest, .rest, .rest,         // Beat 2
        .rest, .rest, .rest,         // Beat 3
        .rest, .rest, .rest          // Beat 4
    ]
    
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
                        droppedRhythms: $droppedRhythms
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
                Button(action: repeatButtonTapped) {
                    Image(systemName: isRepeating ? "repeat" : "repeat.1")
                        .font(.myFont(size: 20))
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: jangdanPlayButtonTapped) {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        .font(.myFont(size: 20))
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
    }
}

private extension CreatingView {
    func repeatButtonTapped() {
        isRepeating.toggle()
    }
    
    func jangdanPlayButtonTapped() {
        if isPlaying {
            stopPlaying()
        } else {
            startPlaying()
        }
    }
    
    func startPlaying() {
        isPlaying = true
        
        currentBeatIndex = 0
        let interval = Double(60) / Double(bpm)
        SoundManager.shared.playSound(name: droppedRhythms[0].sound)
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if !isPlaying || currentBeatIndex >= droppedRhythms.count - 1 {
                if isRepeating {
                    currentBeatIndex = 0
                    SoundManager.shared.playSound(name: droppedRhythms[currentBeatIndex].sound)
                } else {
                    timer.invalidate()
                    stopPlaying()
                    return
                }
            } else {
                currentBeatIndex += 1
                SoundManager.shared.playSound(name: droppedRhythms[currentBeatIndex].sound)
            }
        }
        
    }

    
    func stopPlaying() {
        isPlaying = false
        isRepeating = false
    }
}

#Preview {
    CreatingView()
}
