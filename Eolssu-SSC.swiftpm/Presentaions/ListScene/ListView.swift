import SwiftUI

struct ListView: View {
    @State private var selectedSegment: Segment
    
    enum Segment: Int {
        case learning = 0
        case creating = 1
    }
    
    init(_ initialSegment: Segment) {
        self.selectedSegment = initialSegment
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch selectedSegment {
                case .learning:
                    LearningListView()
                case .creating:
                    CreatingListView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Options", selection: $selectedSegment) {
                    Text("Learning").tag(selectedSegment)
                    Text("Creating").tag(selectedSegment)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 200)
            } 
        }
    }
}

#Preview {
    ListView(.learning)
}
