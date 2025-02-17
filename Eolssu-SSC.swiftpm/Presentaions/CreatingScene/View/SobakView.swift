import SwiftUI

struct SobakView: View {
    @Binding var rhythm: RhythmType
    
    var body: some View {
        Rectangle()
            .stroke(Color.eolssuBrown.opacity(0.6), style: StrokeStyle(lineWidth: 2, dash: [3, 5]))
            .overlay(
                rhythm.letterImage
            )
            .draggable(rhythm)
            .dropDestination(for: RhythmType.self) { items, location in
                guard let droppedItem = items.first else { return false }
                rhythm = droppedItem
                return true
            }
    }
}

#Preview {
    SobakView(rhythm: .constant(RhythmType.dung))     
}
