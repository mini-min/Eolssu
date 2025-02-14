import SwiftUI
import AVFoundation

struct LearningDetailView: View {
    
    @State private var isShowPlayAlert: Bool = false
    @State private var isPlaying: Bool = false
    @State private var currentBeatIndex: Int = 0
    @State private var metronomePlayer: AVAudioPlayer?
    @State private var repeatValue: Int = 1
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
                    Text("Click the letters in time with the beat to play Jang-Dan!")
                        .font(.myFont(size: 32))
                        .foregroundStyle(Color.eolssuBrown)
                    
                    HStack(alignment: .center, spacing: 130) {
                        ForEach(RhythmType.allCases.dropLast(), id: \.self) { rhythm in
                            Button(action: {
                                SoundManager.shared.playSound(name: rhythm.sound)
                            }) {
                                rhythm.letterImage
                                    .scaleEffect(1.8)
                            }
                        }
                    }
                }
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
        .onAppear {
            prepareMetronomeSound()
        }
        .onDisappear {
            stopPlaying() 
        }
    }
}

extension LearningDetailView {
    func prepareMetronomeSound() {
        guard let metronomeSound = Bundle.main.url(forResource: SoundName.metronome.rawValue, withExtension: "mp3") else {
            print("메트로놈 사운드 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            metronomePlayer = try AVAudioPlayer(contentsOf: metronomeSound)
            metronomePlayer?.prepareToPlay()
        } catch {
            print("메트로놈 사운드 초기화 실패: \(error)")
        }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(3 - i)) { 
                countdownValue = i
                
                if i == 0 { 
                    withAnimation(.easeInOut) { countdownValue = nil } 
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
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if !isPlaying {
                timer.invalidate()
                return
            }
                        
            if currentBeatIndex >= jangdan.rhythms.count - 1 {
                currentBeatIndex = 0
                repeatValue += 1
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
        // metronomePlayer?.stop()
    }
}


#Preview {
    LearningDetailView(isDetailViewVisible: .constant(true), jangdan: .hwimori)
}
