import SwiftUI

struct InitialView: View {
    
    enum ScreenState: Int, CaseIterable {
        case first, second, third, final
        
        var next: ScreenState? {
            let allCases = ScreenState.allCases
            if let currentIndex = allCases.firstIndex(of: self), currentIndex < allCases.count - 1 {
                return allCases[currentIndex + 1]
            }
            return nil
        }
        
        var sound: SoundName? {
            switch self {
            case .first: return nil
            case .second: return .dung
            case .third: return .gideok
            case .final: return .eolssu
            }
        }
    }
    
    @State private var screenState: ScreenState = .first
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.eolssuBackground
                    .ignoresSafeArea()
                
                if screenState.rawValue >= 1 {
                    Image.janggu
                        .offset(x: 250, y: 50)
                }
                
                VStack {
                    HStack(alignment: .bottom) {
                        Image.main
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                        
                        if screenState == .final {
                            Button(action: {
                                SoundManager.shared.playSound(name: SoundName.eolssu.rawValue)
                            }, label: {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                            })
                            .tint(.eolssuBrown)
                        }
                    }
                    
                    if screenState == .final {
                        Text("EOLSSU - Learn to Korean traditional rhythm, Jang-Dan")
                            .font(.myFont(size: 30))
                            .foregroundStyle(Color.eolssuBlack)
                            .padding(.top, 50)
                    }
                    
                    VStack(spacing: 35) {
                        Text("“Jang-Dan” means rhythm or beat in Korean traditional music.")
                            .padding(.top, 75)
                          
                        if screenState.rawValue >= 1 {
                            Text("“Janggu” is a traditional Korean drum for playing “Jangdan” like an hourglass.")
                        }
                        
                        if screenState.rawValue >= 2 {
                            Text("Should we learn and make Korean traditional “Jangdan“ using “Janggu”?")
                        }
                    }
                    .font(.myFont(size: 26))
                    .foregroundStyle(Color.eolssuBrown)
                    .padding(.bottom, 70)
                    
                    
                    if screenState == .final {
                        HStack(spacing: 50) {
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

                    Text("Tap on the screen")
                        .font(.myFont(size: 40))
                        .foregroundStyle(Color.eolssuPink)
                        .opacity(screenState == .final ? 0 : 1)
                }
                .padding()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if let nextState = screenState.next { 
                            screenState = nextState 
                            
                            if let sound = screenState.sound?.rawValue {
                                SoundManager.shared.playSound(name: sound)
                            }
                        }
                    }
                }

            }
        }
    }
}
