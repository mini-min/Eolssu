import SwiftUI

final class LearningDetailViewModel: ObservableObject {
    @Published var isShowPlayAlert: Bool = false
    @Published var isShowJungganboAlert: Bool = false
    @Published var isPlaying: Bool = false
    @Published var currentBeatIndex: Int = 0
    @Published var currentRhythm: RhythmType = .rest
    @Published var repeatValue: Int = 0
    @Published var countdownValue: Int? = nil
    
    let jangdan: JangDanType
    
    init(jangdan: JangDanType) {
        self.jangdan = jangdan
    }
    
    func playButtonTapped() {
        if isPlaying {
            stopPlaying()
        } else {
            startCountdown()
        }
    }
    
    func startCountdown() {
        countdownValue = 3 
        
        for i in stride(from: 3, through: 0, by: -1) { 
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(3 - i)) { [weak self] in
                guard let self else { return }
                
                countdownValue = i
                SoundManager.shared.playSound(name: SoundName.metronome.rawValue)
                
                if i == 0 { 
                    withAnimation(.easeInOut) { self.countdownValue = nil }
                    repeatValue = 1
                    startPlaying()
                }
            }
        }
    }
    
    func startPlaying() {
        isPlaying = true
        currentBeatIndex = 0
        
        let interval = Double(60) / Double(jangdan.tempo.bpm)
        if repeatValue % 2 != 0 {
            SoundManager.shared.playSound(name: jangdan.rhythms[0].sound)
        }
        currentRhythm = jangdan.rhythms[0]
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self else { return }
            
            if !isPlaying {
                timer.invalidate()
                return
            }
            
            if currentBeatIndex >= jangdan.rhythms.count - 1 {
                currentBeatIndex = 0
                repeatValue += 1
                if repeatValue > 10 { 
                    stopPlaying() 
                    isShowPlayAlert = true
                }
                if repeatValue % 2 != 0 && jangdan.rhythms[currentBeatIndex] != .rest {
                    SoundManager.shared.playSound(name: jangdan.rhythms[currentBeatIndex].sound)
                }
            } else {
                currentBeatIndex += 1
                if repeatValue % 2 != 0 && jangdan.rhythms[currentBeatIndex] != .rest {
                    SoundManager.shared.playSound(name: jangdan.rhythms[currentBeatIndex].sound)
                }
            }
            currentRhythm = jangdan.rhythms[currentBeatIndex]
        }
    }
    
    func stopPlaying() {
        isPlaying = false
        repeatValue = 0
        currentRhythm = .rest
    }
}
