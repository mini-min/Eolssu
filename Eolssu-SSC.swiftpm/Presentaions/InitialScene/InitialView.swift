import SwiftUI

struct InitialView: View {
    private let componentFactory = EolssuComponentFactory()
    
    var body: some View {            
        NavigationStack {
            ZStack {
                Color.eolssuBackground
                
                VStack {
                    HStack(alignment: .bottom) {
                        Image.main
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                        
                        Button(action: {
                            // play "Eolssu" Sound
                        }, label: {
                            Image(systemName: "play.circle") 
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        })
                        .tint(.eolssuBrown)
                        
                        Button(action: {
                            // Show Tool Tip for description "Eolssu"
                        }, label: {
                            Image(systemName: "questionmark.circle") 
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        })
                        .tint(.eolssuBrown)
                    }
 
                    Text("EOLSSU - Learn to Korean traditional rhythm, JangDan")
                        .font(.myFont(size: 24))
                        .foregroundStyle(Color.eolssuBlack)
                        .padding()
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: ListView(.learning)) {
                            Text("Learning Jang-Dan")
                                .font(.myFont(size: 20)) 
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.eolssuBrown)
                                .cornerRadius(15)
                        }
                        
                        NavigationLink(destination: ListView(.creating)) {
                            Text("Creating Jang-Dan")
                                .font(.myFont(size: 20)) 
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.eolssuBrown)
                                .cornerRadius(15)
                        }
                    }
                }                
            }
        }
    }
}
