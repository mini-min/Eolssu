import SwiftUI

struct LearningDetailView: View {
    
    @State private var isShowPlayAlert: Bool = false
    @State private var isPlaying: Bool = false
    @State private var currentBeatIndex: Int = 0
    @State private var repeatValue: Int = 0
    @State private var countdownValue: Int? = nil
    @State private var playingJangdans: [RhythmType] = []
    @State private var playingScore: Score = .good
    
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
                    
                    PerformRhythmView(repeatValue: $repeatValue)
//                    HStack(alignment: .center, spacing: 130) {
//                        ForEach(RhythmType.allCases.dropLast(), id: \.self) { rhythm in
//                            Button(action: {
//                                SoundManager.shared.playSound(name: rhythm.sound)
//                                soundRhythmImageTapped(rhythm)
//                            }) {
//                                rhythm.letterImage
//                                    .scaleEffect(1.8)
//                            }
//                        }
//                    }
                }
                .padding(.bottom, 80)
                                
                ScoreView(scoreStatus: $playingScore)
                    .cornerRadius(20)
                    .frame(height: 120)
                    .padding(.horizontal, 50)
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
                HowToPlayAlert(isPresentedAlert: $isShowPlayAlert)
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
        playingJangdans = []
        
        let interval = Double(60) / Double(jangdan.tempo.bpm)
        
        if repeatValue % 2 != 0 {
            SoundManager.shared.playSound(name: jangdan.rhythms[0].sound)
        }
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if !isPlaying {
                timer.invalidate()
                return
            }
                        
            if currentBeatIndex >= jangdan.rhythms.count - 1 {
                currentBeatIndex = 0
                repeatValue += 1
                playingJangdans = []
                if repeatValue % 2 != 0 {
                    SoundManager.shared.playSound(name: jangdan.rhythms[currentBeatIndex].sound)
                }
            } else {
                currentBeatIndex += 1
                if repeatValue % 2 != 0 {
                    SoundManager.shared.playSound(name: jangdan.rhythms[currentBeatIndex].sound)
                }
            }
        }
    }
    
    func stopPlaying() {
        isPlaying = false
        repeatValue = 0
    }
    
    func compareArrays() {
        let matchingScore = zip(jangdan.rhythms, playingJangdans).filter { $0 == $1 }.count
        
        if matchingScore >= jangdan.rhythms.count - 1 {
            playingScore = .perfect
        } else if matchingScore >= jangdan.rhythms.count / 2 - 1 {
            playingScore = .good
        } else {
            playingScore = .oops
        }
    }
    
    func soundRhythmImageTapped(_ rhythm: RhythmType) {
        if repeatValue % 2 == 0 && currentBeatIndex < jangdan.rhythms.count {
            if playingJangdans.count > currentBeatIndex {
                playingJangdans[currentBeatIndex] = rhythm // 이미 값이 있으면 덮어쓰기
            } else {
                playingJangdans.append(rhythm) // 값이 없으면 추가
            }
        }
    }
}


#Preview {
    LearningDetailView(
        isDetailViewVisible: .constant(true), 
        jangdan: .hwimori
    )
}
