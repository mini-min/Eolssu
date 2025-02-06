import SwiftUI

struct LearningCard: View {
    var jangdan: JangDanType
    
    var body: some View {
        ZStack {
            Color.eolssuBackground
            
            Image.janggu2
                .offset(x: 250, y: 50)
            
            VStack(alignment: .leading, spacing: 40) {
                HStack(alignment: .bottom, spacing: 25) {
                    Text(jangdan.korTitle)
                        .font(.myFont(size: 90))
                        .asColor("jangdan.korTitle", with: .eolssuPink)
                    
                    Text(jangdan.engTitle)
                        .font(.myFont(size: 40))
                        .asColor("jangdan.korTitle", with: .eolssuPink)
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
    }
}

#Preview {
    let dummyData = JangDanType.jajinmori
    LearningCard(jangdan: JangDanType.jajinmori)
}
