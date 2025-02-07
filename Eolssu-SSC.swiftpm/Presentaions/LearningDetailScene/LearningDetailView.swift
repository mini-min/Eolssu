import SwiftUI

struct LearningDetailView: View {
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Text(jangdan.korTitle)
                    Text(jangdan.engTitle)
                }
                .foregroundStyle(Color.eolssuBrown)
                .font(.myFont(size: 24))
                
                
                HStack(spacing: 0) {
                    ForEach(0..<jangdan.beat, id: \.self) { outIndex in
                        GeometryReader { geometry in
                            ZStack {
                                Rectangle()
                                    .stroke(Color.eolssuBrown, lineWidth: 5)
                                
                                HStack(spacing: 0) {
                                    ForEach(0..<jangdan.sobak, id: \.self) { inIndex in
                                        let rhythmIndex = outIndex * jangdan.sobak + inIndex
                                        
                                        Rectangle()
                                            .stroke(Color.eolssuBrown.opacity(0.6), style:  StrokeStyle(lineWidth: 2, dash: [3, 5]))
                                            .overlay {
                                                if rhythmIndex < jangdan.rhythms.count {
                                                    jangdan.rhythms[rhythmIndex].iconImage
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
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
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    LearningDetailView(jangdan: .jungjungmori)
}
