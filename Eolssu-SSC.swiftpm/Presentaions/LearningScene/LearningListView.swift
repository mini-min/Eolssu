import SwiftUI

struct LearningView: View {
    
    @State private var selectedJangdan = 0
    @State private var offset = CGFloat.zero
    @State private var isDetailViewVisible = false
    @State private var isSpeaking = true
    
    private let jangdans = JangDanType.allCases
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Text("“Please select the rhythm pattern you want to learn.”")
                    .font(.myFont(size: 32))
                    .foregroundColor(.white)
                
                GeometryReader { geometry in
                    let width = geometry.size.width * 0.7
                    
                    LazyHStack(spacing: 30) {
                        Color.clear.frame(width: geometry.size.width * 0.15 - 30)
                        ForEach(0..<jangdans.count, id: \.self) { index in
                            LearningCard(jangdan: jangdans[index])
                                .frame(width: width, height: 500)
                                .scaleEffect((index % jangdans.count) == selectedJangdan ? 1 : 0.85)
                                .opacity(index == selectedJangdan ? 1 : 0.5)
                                .padding(.vertical)
                                .onTapGesture {
                                    withAnimation(.spring) { isDetailViewVisible = true }
                                }
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
                                let threshold: CGFloat = width / 2
                                if value.translation.width < -threshold {
                                    if selectedJangdan != jangdans.count - 1 { selectedJangdan += 1 }
                                } else if value.translation.width > threshold {
                                    if selectedJangdan != 0 { selectedJangdan -= 1 }
                                }
                                withAnimation(.spring()) {
                                    offset = 0
                                }
                            }
                    )
                }
                .frame(height: 500)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                LearningCardPageIndicator(
                    count: jangdans.count,
                    currentIndex: selectedJangdan
                ) { index in
                    selectedJangdan = index
                }
            }
            if isDetailViewVisible {
                LearningDetailView(
                    isDetailViewVisible: $isDetailViewVisible, 
                    jangdan: jangdans[selectedJangdan]
                )
                .toolbar(.hidden, for: .navigationBar)
                .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
            }
        }
        .onChange(of: selectedJangdan) { selectedJangdan in
            if isSpeaking { TTSManager.shared.speak(text: jangdans[selectedJangdan].korTitle) }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isSpeaking.toggle()
                } label: {
                    Image(systemName: isSpeaking ? "speaker.wave.1.fill" : "speaker.slash.fill")
                        .font(.myFont(size: 20))
                        .foregroundStyle(Color.white)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    LearningView()
}
