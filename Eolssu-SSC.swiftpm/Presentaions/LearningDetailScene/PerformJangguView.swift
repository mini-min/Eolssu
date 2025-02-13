import SwiftUI

struct PerformJangguView: View {    
    @State private var isLeftTapped = false
    @State private var isRightTapped = false
    @State private var isDoubleTapped = false
    @State private var isTripleTapped = false
    
    var body: some View {
        ZStack {
            Color.white
            
            GeometryReader { geometry in
                let centerX = geometry.size.width / 2

                ZStack {
                    Image.janggu3
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8)
                    
                    Rectangle()
                        .fill(Color.brown)
                        .frame(width: 2, height: geometry.size.height * 0.8)
                        .opacity(0.5)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .contentShape(Rectangle())
                .gesture(
                    SimultaneousGesture(
                        SpatialTapGesture()
                            .onEnded { event in
                                if event.location.x < centerX { 
                                    isLeftTapped = true
                                    SoundManager.shared.playSound(name: SoundName.kung.rawValue) 
                                }
                            }, 
                        SpatialTapGesture()
                            .onEnded { event in
                                if event.location.x > centerX { 
                                    isRightTapped = true
                                    SoundManager.shared.playSound(name: SoundName.deok.rawValue) 
                                }
                            }
                    )
                )
                .onTapGesture(count: 2) { location in
                    if location.x > centerX {
                        isDoubleTapped = true
                        SoundManager.shared.playSound(name: SoundName.gideok.rawValue)
                    }
                }
                .onTapGesture(count: 3) { location in
                    if location.x > centerX {
                        isTripleTapped = true
                        SoundManager.shared.playSound(name: SoundName.deoreo.rawValue)
                    }
                }
            }
        }
        .cornerRadius(20)
    }
}

#Preview {
    PerformJangguView()
}
