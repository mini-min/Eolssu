import SwiftUI

struct CreatingControlView: View {
    
    @Binding var bpm: Int
    @Binding var droppedRhythms: [RhythmType]
    @Binding var isPlaying: Bool    
    @Binding var currentBeatIndex: Int
    
    var body: some View {
        HStack(spacing: 200) {
            HStack {
                Button(action: { bpm -= 1 }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
                
                Text("\(bpm) BPM")
                    .font(.myFont(size: 20))
                    .padding(.horizontal, 20)
                
                Button(action: { bpm += 1 }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
            }
            .foregroundColor(.eolssuBrown)
            .padding()
            
            Button(action: jangdanPlayButtonTapped) {
                Text(isPlaying ? "Stop" : "Play Jang-Dan")
                    .font(.myFont(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.eolssuBrown)
                    .cornerRadius(15)
            }
        }
    }
}

extension CreatingControlView {
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
                timer.invalidate()
                stopPlaying()
                return
            } else {
                currentBeatIndex += 1 
                SoundManager.shared.playSound(name: droppedRhythms[currentBeatIndex].sound)
            }
        }
        
    }
    
    func stopPlaying() {
        isPlaying = false
    }
}

#Preview {
    CreatingControlView(
        bpm: .constant(100), 
        droppedRhythms: .constant(JangDanType.gutgeori.rhythms), 
        isPlaying: .constant(false), 
        currentBeatIndex: .constant(0)
    )
}
