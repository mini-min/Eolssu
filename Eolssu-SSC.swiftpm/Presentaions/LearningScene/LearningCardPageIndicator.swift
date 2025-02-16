import SwiftUI

struct LearningCardPageIndicator: View {
    let count: Int
    let currentIndex: Int
    let onTap: (Int) -> Void
    
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .frame(width: 10)
                    .foregroundColor(index == currentIndex ? .white : .eolssuGray2)
                    .onTapGesture { onTap(index) }
            }
        }
    }
}
