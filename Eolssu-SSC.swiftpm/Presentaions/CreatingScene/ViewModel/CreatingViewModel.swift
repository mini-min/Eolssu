import Combine
import SwiftUI

final class CreatingViewModel: ObservableObject {
    @Published var bpm: Int = 100
    @Published var isPlaying: Bool = false
    @Published var isRepeating: Bool = false
    @Published var currentBeatIndex: Int = 0
    @Published var droppedRhythms: [RhythmType] = [
        .rest, .rest, .rest,         // Beat 1
        .rest, .rest, .rest,         // Beat 2
        .rest, .rest, .rest,         // Beat 3
        .rest, .rest, .rest          // Beat 4
    ]
        
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
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self else { return }
            
            if !isPlaying || currentBeatIndex >= droppedRhythms.count - 1 {
                if isRepeating {
                    currentBeatIndex = 0
                    if droppedRhythms[currentBeatIndex] != .rest {
                        SoundManager.shared.playSound(name: droppedRhythms[currentBeatIndex].sound)
                    }
                } else {
                    timer.invalidate()
                    stopPlaying()
                    return
                }
            } else {
                currentBeatIndex += 1
                if droppedRhythms[currentBeatIndex] != .rest {
                    SoundManager.shared.playSound(name: droppedRhythms[currentBeatIndex].sound)
                }
            }
        }
        
    }
    
    func stopPlaying() {
        isPlaying = false
        isRepeating = false
    }
}
