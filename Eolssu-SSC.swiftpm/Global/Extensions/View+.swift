import SwiftUI

extension View {
    /// 앱에서 사용하는 버튼 스타일을 재사용하는 메서드
    func eolssuButtonStyle() -> some View {
        self.modifier(EolssuButtonStyle())
    }
}
