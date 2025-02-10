import SwiftUI

struct CreatingView: View {
    
    @State private var bpm: Int = 100
    private let rhythms = RhythmType.allCases
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text("Rhythms")
                    .font(.myFont(size: 32))
                    .foregroundStyle(Color.eolssuBrown)
                    .padding(.bottom, 10)
                    .padding([.top, .leading], 25)
                
                Text("Drag Korean letters to make\nyour own cool korean rhythm!")
                    .font(.myFont(size: 16))
                    .foregroundStyle(Color.eolssuBrown)
                    .padding(.leading, 25)
                    .padding(.bottom, 30)
                
                ForEach(0..<rhythms.count-1, id: \.self) { index in
                    HStack(spacing: 25) {
                        rhythms[index].letterImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            HStack {
                                Text(rhythms[index].rawValue)
                                    .font(.myFont(size: 24))
                                    .foregroundStyle(Color.eolssuBlack)
                                
                                Button(action: {
                                    SoundManager.shared.playSound(name: rhythms[index].sound)
                                }, label: {
                                    Image(systemName: "speaker.wave.2")
                                        .foregroundColor(.eolssuBrown)
                                })
                            }
                            
                            Text(rhythms[index].description)
                                .font(.myFont(size: 12))
                                .foregroundStyle(Color.eolssuGray3)
                        }
                    }
                    .padding()
                }
            }
            .frame(width: 300)
            .background(Color.eolssuBackground)
            .cornerRadius(20)
            
            
            VStack {
                HStack(spacing: 0) {
                    ForEach(0..<4, id: \.self) { outIndex in
                        GeometryReader { geometry in
                            ZStack {
                                Rectangle()
                                    .stroke(Color.eolssuBrown, lineWidth: 5)
                                
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { inIndex in
                                        Rectangle()
                                            .stroke(Color.eolssuBrown.opacity(0.6), style:  StrokeStyle(lineWidth: 2, dash: [3, 5]))
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: 80)
                .padding()
                
                VStack(spacing: 0) {
                    ForEach(0..<2, id: \.self) { outIndex in
                        HStack(spacing: 0) {
                            ForEach(0..<2, id: \.self) { innerIndex in
                                Rectangle()
                                    .stroke(Color.eolssuBrown.opacity(0.6), style:  StrokeStyle(lineWidth: 2, dash: [3, 5]))
                                    .background(Color.white)
                                    .overlay(
                                        Text("Beat \(outIndex * 2 + innerIndex + 1)")
                                            .foregroundColor(.eolssuBrown.opacity(0.5))
                                            .font(.myFont(size: 32))
                                    )
                            }
                        }
                    }
                }
                .padding()
                .cornerRadius(20)
                
                HStack(spacing: 200) {
                    HStack {
                        Button(action: { bpm -= 1 }) {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        }
                        
                        Text("\(bpm) BPM")
                            .font(.myFont(size: 20))
                            .padding(.horizontal, 20)
                        
                        Button(action: { bpm += 1 }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        }
                    }
                    .foregroundColor(.eolssuBrown)
                    .padding()
                    
                    Button(action: { /* 장단 플레이 기능 */ }) {
                        Text("Play Jang-Dan")
                            .font(.myFont(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.eolssuBrown)
                            .cornerRadius(15)
                    }
                }
            }
            .background(Color.eolssuBackground)
            .cornerRadius(20)
        }
    }
}

#Preview {
    CreatingView()
}
