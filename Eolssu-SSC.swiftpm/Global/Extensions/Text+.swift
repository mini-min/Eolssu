import SwiftUI

extension Text {
    
    /// [String] 타입으로 넘어온 텍스트에 대해 Bullest 처리를 하기 위한 메서드
    init(bulletArray items: [String]) {
        let bulletList = items.map { "• \($0)" }.joined(separator: "\n")
        self.init(bulletList)
    }
}
