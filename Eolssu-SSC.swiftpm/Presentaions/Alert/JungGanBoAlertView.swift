import SwiftUI

struct JungGanBoAlert: View {
    
    @Binding var isShowJungganboAlert: Bool
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4) 
                .ignoresSafeArea()
            
            ZStack {
                JungGanBoView(
                    rhythmList: .constant(jangdan.rhythms),
                    jangdanBeat: .constant(jangdan.beat),
                    jangdanSobak: .constant(jangdan.sobak),
                    isPlaying: .constant(false),
                    currentBeatIndex: .constant(0)
                )
                .frame(width: 800, height: 80)
                .opacity(0.2)
                
                VStack(spacing: 50) {
                    Text("What is Jeongganbo?")
                        .font(.myFont(size: 32))
                        .foregroundStyle(Color.eolssuBrown)
                    Text(
                    """
                    Jeongganbo, meaning “square notation,” is traditional Korean musical notation system.
                    developed the reign of King Sejong in the 15th century.
                    It is one of the earliest examples of mensural notation in East Asia,
                    designed to represent both the pitch and duration of musical notes using grid.
                    """
                    )
                        .font(.myFont(size: 24))
                        .foregroundStyle(Color.eolssuBrown)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                        .lineSpacing(25)
                    
                    Button(action: { isShowJungganboAlert.toggle() }) {
                        Text("Let's Learning Jang-Dan!")
                    }
                    .eolssuButtonStyle()
                }
            }
            .padding(.vertical, 50)
            .frame(width: 1100)
            .background(Color.white)
            .cornerRadius(20)
        }
        .onAppear() {
            SoundManager.shared.playSound(name: SoundName.eolssu.rawValue)
        }
    }
}

#Preview {
    JungGanBoAlert(
        isShowJungganboAlert: .constant(true),
        jangdan: .gutgeori
    )
}
