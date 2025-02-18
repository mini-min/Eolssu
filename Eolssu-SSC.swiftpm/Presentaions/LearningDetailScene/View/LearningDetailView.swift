import SwiftUI

struct LearningDetailView: View {
        
    @StateObject private var viewModel: LearningDetailViewModel
    @Binding var isDetailViewVisible: Bool
    
    init(isDetailViewVisible: Binding<Bool>, jangdan: JangDanType) {
        _isDetailViewVisible = isDetailViewVisible
        _viewModel = StateObject(wrappedValue: LearningDetailViewModel(jangdan: jangdan))
    }
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            viewModel.stopPlaying()
                            isDetailViewVisible = false 
                        }
                    }, label: { 
                        Image(ImageName.list.rawValue)
                    })
                    
                    Spacer()
                    
                    HStack {
                        Text(viewModel.jangdan.korTitle)
                        Text(viewModel.jangdan.engTitle)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: viewModel.playButtonTapped) {
                            Image(systemName: viewModel.isPlaying ? "stop.fill" : "play.fill")
                        }
                        
                        Button(action: {
                            viewModel.isShowJungganboAlert = true
                        }, label: {
                            Image(systemName: "questionmark.circle")
                        })
                    }
                }
                .foregroundStyle(Color.eolssuBrown)
                .font(.myFont(size: 24))
                .padding(30)
                
                Spacer()
                
                JungGanBoView(
                    rhythmList: .constant(viewModel.jangdan.rhythms),
                    jangdanBeat: .constant(viewModel.jangdan.beat),
                    jangdanSobak: .constant(viewModel.jangdan.sobak),
                    isPlaying: $viewModel.isPlaying,
                    currentBeatIndex: $viewModel.currentBeatIndex
                )
                .frame(width: CGFloat(viewModel.jangdan.beat * 270), height: 90)
                .padding(.bottom, 50)
                
                VStack(spacing: 50) {
                    ZStack {
                        if viewModel.repeatValue % 2 != 0 {
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
                    .animation(.easeInOut(duration: 0.3), value: viewModel.repeatValue)
                    
                    PerformRhythmView(
                        repeatValue: $viewModel.repeatValue, 
                        currentRhythm: $viewModel.currentRhythm
                    )
                    .background(Color.white)
                    .cornerRadius(20)
                    .frame(height: 400)
                }
                Spacer()
            }
            
            if let countdownValue = viewModel.countdownValue { 
                CountdownView(countdownValue: countdownValue) 
            }
            
            if viewModel.isShowPlayAlert {
                HowToPlayAlert(
                    isDetailViewVisible: $isDetailViewVisible,
                    jangdan: viewModel.jangdan
                )
            }
            if viewModel.isShowJungganboAlert {
                JungGanBoAlert(
                    isShowJungganboAlert: $viewModel.isShowJungganboAlert,
                    jangdan: viewModel.jangdan
                )
            }
        }
        .onDisappear {
            viewModel.stopPlaying() 
        }
    }
}

#Preview {
    LearningDetailView(
        isDetailViewVisible: .constant(true), 
        jangdan: .hwimori
    )
}
