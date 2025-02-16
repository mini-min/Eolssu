import SwiftUI

struct ListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedSegment: Segment
    
    enum Segment: Int, CaseIterable {
        case learning = 0
        case creating = 1
    }
    
    init(_ initialSegment: Segment) {
        self.selectedSegment = initialSegment
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.eolssuBrown, .eolssuDarkBrown]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    switch selectedSegment {
                    case .learning:
                        LearningView()
                    case .creating:
                        CreatingView()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundStyle(Color.white)
                    .font(.myFont(size: 18))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Picker("Options", selection: $selectedSegment) {
                    Text("Learning").tag(Segment.learning)
                    Text("Creating").tag(Segment.creating)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 275, maxHeight: 50)
            }
        }
    }
}

#Preview {
    ListView(.learning)
}
