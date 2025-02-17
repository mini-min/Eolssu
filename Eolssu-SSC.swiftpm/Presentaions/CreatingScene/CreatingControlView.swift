import SwiftUI

struct CreatingControlView: View {
    
    @Binding var bpm: Int
    @Binding var droppedRhythms: [RhythmType]
    
    var body: some View {
        HStack(spacing: 130) {
            VStack {
                HStack(spacing: 30) {
                    Button(action: { bpm = max(50, bpm - 1) }) {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    
                    Text("\(bpm) BPM")
                        .font(.myFont(size: 20))
                    
                    Button(action: { bpm = min(150, bpm + 1) }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                }
                .foregroundColor(.eolssuBrown)
                
                Slider(value: Binding(
                    get: { Double(bpm) },
                    set: { bpm = Int($0) }
                ), in: 50...150, step: 5)
                .accentColor(.eolssuBrown)
                .frame(width: 230)
            }
            
            Button(action: resetDroppedRhythms) {
                Label("Reset Jang-Dan", systemImage: "arrow.trianglehead.2.clockwise")
                    .labelStyle(.titleAndIcon)
                    .font(.myFont(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.eolssuBrown)
                    .cornerRadius(15)
            }
        }
    }
}

private extension CreatingControlView {
    func resetDroppedRhythms() {
        droppedRhythms = Array(repeating: .rest, count: droppedRhythms.count)
    }
}

#Preview {
    CreatingControlView(
        bpm: .constant(100),
        droppedRhythms: .constant(JangDanType.gutgeori.rhythms)
    )
}
