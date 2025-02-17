import SwiftUI

struct HowToPlayAlert: View {
    
    @Binding var isDetailViewVisible: Bool
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4) 
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                Text("Perfect!")
                    .font(.myFont(size: 32))
                    .foregroundStyle(Color.eolssuBrown)
                
                JungGanBoView(
                    rhythmList: .constant(jangdan.rhythms),
                    jangdanBeat: .constant(jangdan.beat),
                    jangdanSobak: .constant(jangdan.sobak),
                    isPlaying: .constant(false),
                    currentBeatIndex: .constant(0)
                )
                .frame(width: 800, height: 80)
                .padding()
                
                Text("This tranditional Korean rhythm you learned is \(jangdan).")
                    .font(.myFont(size: 24))
                    .foregroundStyle(Color.eolssuBrown)
                    .padding(.bottom, 10)
                
                
                Button(action: {
                    isDetailViewVisible.toggle()
                }) {
                    Text("Learning other Jang-Dan")
                        .font(.myFont(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.eolssuBrown)
                        .cornerRadius(15)
                }
            }
            .padding(.vertical, 50)
            .frame(width: 920)
            .background(Color.white)
            .cornerRadius(20)
        }
        .onAppear() {
            SoundManager.shared.playSound(name: SoundName.eolssu.rawValue)
        }
    }
}

#Preview {
    HowToPlayAlert(isDetailViewVisible: .constant(true), jangdan: .gutgeori)
}
