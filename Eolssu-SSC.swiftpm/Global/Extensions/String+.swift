import SwiftUI

extension String {
    
    /// 원하는 인덱스의 글자를 가져올 수 있도록 하는 메서드
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < self.count else { return nil }
        let targetIndex = self.index(self.startIndex, offsetBy: index)
        return self[targetIndex]
    }
}
