import SwiftUI

struct ListView: View {
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
                Color.eolssuBackground
                    .ignoresSafeArea()
                
                VStack {
                    switch selectedSegment {
                    case .learning:
                        LearningListView()
                    case .creating:
                        CreatingListView()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Options", selection: $selectedSegment) {
                    Text("Learning").tag(Segment.learning)
                    Text("Creating").tag(Segment.creating)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 250)
            }
        }
    }
}

#Preview {
    ListView(.learning)
}
