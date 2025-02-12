import SwiftUI

struct LearningDetailView: View {
    
    @State private var isShowPlayAlert: Bool = false
    @State private var isPlaying: Bool = false
    @State private var currentBeatIndex: Int = 0
    
    @Binding var isDetailViewVisible: Bool
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
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
                        Button(action: {
                            // 노래가 재생
                        }, label: {
                            Image(systemName: "play")
                        })
                        
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
                
                HStack(alignment: .bottom) {
                    ForEach(jangdan.rhythms, id: \.self) { rhythm in
                        if rhythm == .rest { Spacer() }
                        rhythm.letterImage
                            .renderingMode(.template)
                            .foregroundColor(.eolssuGray2)
                            .scaledToFit()
                    }
                }
                .frame(width: CGFloat(jangdan.beat * 290), height: 150)
                
                PerformJangguView()
                    .padding([.leading, .trailing], 30)
            }
            
            if isShowPlayAlert {
                HowToPlayAlert(isPresentedAlert: $isShowPlayAlert)
            }
        }
    }
}

#Preview {
    LearningDetailView(isDetailViewVisible: .constant(true), jangdan: .jungjungmori)
}
