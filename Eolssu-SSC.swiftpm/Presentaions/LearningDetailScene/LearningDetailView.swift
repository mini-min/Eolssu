import SwiftUI

struct LearningDetailView: View {
    
    @State private var isShowPlayAlert: Bool = false
    @State private var isPlaying: Bool = false
    @State private var currentBeatIndex: Int = 0
    @State private var currentRhythm: RhythmType = .rest
    @State private var repeatValue: Int = 0
    @State private var countdownValue: Int? = nil
        
    @Binding var isDetailViewVisible: Bool
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            stopPlaying()
                            isDetailViewVisible = false 
                        }
                    }, label: {
                        Image.list
                    })
                    
                    Spacer()
                    
                    HStack {
                        Text(jangdan.korTitle)
                        Text(jangdan.engTitle)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: playButtonTapped) {
                            Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        }
                        
                        Button(action: {
                            isShowPlayAlert = true
                        }, label: {
                            Image(systemName: "questionmark.circle")
                        })
                    }
                }
                .foregroundStyle(Color.eolssuBrown)
                .font(.myFont(size: 24))
                .padding(30)
                
                
                JungGanBoView(
                    rhythmList: .constant(jangdan.rhythms),
                    jangdanBeat: .constant(jangdan.beat),
                    jangdanSobak: .constant(jangdan.sobak),
                    isPlaying: $isPlaying,
                    currentBeatIndex: $currentBeatIndex
                )
                .frame(width: CGFloat(jangdan.beat * 270), height: 90)
                .padding()
                
                VStack(spacing: 100) {
                    ZStack {
                        if repeatValue % 2 != 0 {
                            withAnimation {
                                Label("Listen to the Jang-Dan!", systemImage: "ear")
                                    .font(.myFont(size: 32))
                                    .foregroundStyle(Color.eolssuBrown)
                                    .transition(.slide)
                            }
                        } else {
                            withAnimation {
                                Text("Click the letters in time with the beat to play Jang-Dan!")
                                    .font(.myFont(size: 32))
                                    .foregroundStyle(Color.eolssuBrown)
                                    .transition(.opacity)
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: repeatValue)
                    
                    PerformRhythmView(
                        repeatValue: $repeatValue, 
                        currentRhythm: $currentRhythm
                    )
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .padding(.bottom, 80)
            }
            
            if let countdownValue {
                ZStack {
                    Color.black.opacity(0.4)
                    VStack(spacing: 50) {
                        Text("\(countdownValue)")
                            .font(.myFont(size: 200))
                            .foregroundColor(.white)
                            .transition(.opacity.combined(with: .scale)) 
                        
                        Text("Playback will start shortly.\nListen to the Jang-Dan twice, then try playing along to the beat yourself!")
                            .font(.myFont(size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
            if isShowPlayAlert {
                HowToPlayAlert(isDetailViewVisible: $isDetailViewVisible)
            }
        }
        .onDisappear {
            stopPlaying() 
        }
    }
}

extension LearningDetailView {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(3 - i)) { 
                countdownValue = i
                SoundManager.shared.playSound(name: SoundName.metronome.rawValue)
                
                if i == 0 { 
                    withAnimation(.easeInOut) { countdownValue = nil }
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
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
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
                if repeatValue % 2 != 0 {
                    SoundManager.shared.playSound(name: jangdan.rhythms[currentBeatIndex].sound)
                }
            } else {
                currentBeatIndex += 1
                if repeatValue % 2 != 0 {
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


#Preview {
    LearningDetailView(
        isDetailViewVisible: .constant(true), 
        jangdan: .hwimori
    )
}
