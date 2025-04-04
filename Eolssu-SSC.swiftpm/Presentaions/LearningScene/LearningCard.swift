import SwiftUI

struct LearningCard: View {
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
            
            Image(ImageName.janggu2.rawValue)
                .offset(x: 250, y: 50)
            
            VStack(alignment: .leading, spacing: 40) {
                HStack(alignment: .bottom, spacing: 25) {
                    EolssuText(
                        originalText: jangdan.korTitle,
                        targetText: jangdan.korTitle.character(at: 1).map { String($0) } ?? "",
                        targetColor: .eolssuPink
                    ).font(.myFont(size: 90))
                    
                    Text(jangdan.engTitle)
                        .foregroundStyle(Color.eolssuBlack)
                        .font(.myFont(size: 40))
                }
                
                Text(bulletArray: jangdan.description)
                    .font(.myFont(size: 20))
                    .foregroundStyle(Color.eolssuBlack)
                    .lineSpacing(20)
                
                HStack(spacing: 15) {
                    Text(jangdan.tempo.rawValue)
                        .foregroundColor(jangdan.tempo.textColor)
                        .padding(10)
                        .background(jangdan.tempo.backColor)
                        .cornerRadius(12)
                                        
                    Text(jangdan.level.rawValue)
                        .foregroundColor(jangdan.level.textColor)
                        .padding(10)
                        .background(jangdan.level.backColor)
                        .cornerRadius(12)
                    
                    Text("\(jangdan.sobak) sobak, \(jangdan.beat) beats")
                        .foregroundColor(.eolssuBrown)
                        .padding(10)
                        .background(Color.rhythmBack)
                        .cornerRadius(12)

                }
                .font(.myFont(size: 20))
            }
        }
        .cornerRadius(20)
        .padding(20)
    }
}

#Preview {
    LearningCard(jangdan: JangDanType.jajinmori)
}
