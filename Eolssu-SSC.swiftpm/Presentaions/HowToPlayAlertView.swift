import SwiftUI

struct HowToPlayAlert: View {
    
    @State private var selectedImageStatus: Int = 0
    @Binding var isDetailViewVisible: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4) 
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 30) {
                    Text("How play the Jang-Dan?")
                        .font(.myFont(size: 32))
                        .foregroundStyle(Color.eolssuBrown)
                    
                    Text("You can play the “janggu” (a traditional Korean drum) on the screen as follows")
                        .font(.myFont(size: 20))
                        .foregroundStyle(Color.eolssuGray2)
                }
                .padding([.bottom], 60)
                
                HStack(spacing: 90) {
                    Button(action: {
                        withAnimation(.easeInOut) { selectedImageStatus = 1 }
                    }) {
                        Image.guideLeft
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut) { selectedImageStatus = 2 }
                    }) {
                        Image.guideBoth
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut) { selectedImageStatus = 3 }
                    }) {
                        Image.guideRight
                    }
                }
                .padding([.bottom], 50)
                
                Group {
                    if selectedImageStatus == 1 {
                        Text("Tap the left side to play “Kung“.")
                            .font(.myFont(size: 28))
                            .foregroundStyle(Color.eolssuBrown)
                            .transition(.opacity.combined(with: .scale)) 
                    } else if selectedImageStatus == 2 {
                        Text("Tap both left and right sides simultaneously to play “Deong“.")
                            .font(.myFont(size: 28))
                            .foregroundStyle(Color.eolssuBrown)
                            .transition(.opacity.combined(with: .scale)) 
                    } else if selectedImageStatus == 3 {
                        Text("Tap the right side to play “Deok“.\nTap twice quickly to play “Gideok”, three times “Deoreoreoreo”")
                            .font(.myFont(size: 28))
                            .foregroundStyle(Color.eolssuBrown)
                            .transition(.opacity.combined(with: .scale)) 
                    } else {
                        Text("Click on the image to learn how to play😊")
                            .lineSpacing(160)
                            .font(.myFont(size: 28))
                            .foregroundStyle(Color.eolssuBrown)
                            .transition(.opacity.combined(with: .scale)) 
                    }
                }
                .animation(.easeInOut, value: selectedImageStatus) 
                
                Spacer().frame(height: 50)
                
                Button(action: {
                    isDetailViewVisible.toggle()
                }) {
                    Text("Let’s Play Jang-Dan")
                        .font(.myFont(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.eolssuBrown)
                        .cornerRadius(15)
                }
            }
            .padding(.vertical, 50)
            .frame(width: 1000)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

#Preview {
    HowToPlayAlert(isDetailViewVisible: .constant(true))
}
