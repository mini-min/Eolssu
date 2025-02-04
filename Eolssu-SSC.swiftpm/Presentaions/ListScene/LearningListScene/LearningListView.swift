import SwiftUI

struct LearningListView: View {
    
    @State private var selectedJangdan = 0
    @State private var offset = CGFloat.zero
    
    private let jangdans = JangDanType.allCases
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
            
            VStack {
                Text("“Please select the rhythm pattern you want to learn.”")
                    .font(.myFont(size: 32))
                    .foregroundColor(.eolssuBrown)
                
                GeometryReader { geometry in
                    let width = geometry.size.width * 0.7
                    
                    LazyHStack(spacing: 30) {
                        Color.clear.frame(width: geometry.size.width * 0.15 - 30)
                        ForEach(0..<jangdans.count, id: \.self) { index in
                            LearningCard(text: jangdans[index].title)
                                .frame(width: width)
                                .scaleEffect((index % jangdans.count) == selectedJangdan ? 1 : 0.85)
                                .padding(.vertical)
                        }
                    }
                    .offset(x: CGFloat(-selectedJangdan) * (width + 30) + offset)
                    .animation(.spring(), value: selectedJangdan)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation.width
                            }
                            .onEnded { value in
                                let predictedIndex = selectedJangdan - Int((value.predictedEndTranslation.width / width).rounded())
                                
                                withAnimation(.spring()) {
                                    selectedJangdan = (predictedIndex + jangdans.count) % jangdans.count
                                    offset = 0
                                }
                            }
                    )
                }
                .frame(height: 350)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<jangdans.count, id: \.self) { index in
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(index == selectedJangdan ? .primary : .secondary.opacity(0.5))
                            .onTapGesture { selectedJangdan = index }
                    }
                }
            }
            
        }
    }
}

#Preview {
    LearningListView()
}
