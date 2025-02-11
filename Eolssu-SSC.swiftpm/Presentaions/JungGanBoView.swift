import SwiftUI

struct JungGanBoView: View {
    
    @Binding var rhythmList : [RhythmType]
    @Binding var jangdanBeat: Int
    @Binding var jangdanSobak: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<jangdanBeat, id: \.self) { outIndex in
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .stroke(Color.eolssuBrown, lineWidth: 5)
                        
                        HStack(spacing: 0) {
                            ForEach(0..<jangdanSobak, id: \.self) { inIndex in
                                let rhythmIndex = outIndex * jangdanSobak + inIndex
                                
                                Rectangle()
                                    .stroke(Color.eolssuBrown.opacity(0.6), style:  StrokeStyle(lineWidth: 2, dash: [3, 5]))
                                    .overlay {
                                        if rhythmIndex < rhythmList.count {
                                            rhythmList[rhythmIndex].iconImage
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let jajinmori = JangDanType.jajinmori
    
    JungGanBoView(
        rhythmList: .constant(jajinmori.rhythms), 
        jangdanBeat: .constant(jajinmori.beat), 
        jangdanSobak: .constant(jajinmori.sobak)
    )
}
