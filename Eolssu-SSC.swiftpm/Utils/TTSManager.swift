import AVFoundation
import SwiftUI

final class TTSManager {
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(
        text: String,
        language: String = "ko-KR",
        rate: Float = AVSpeechUtteranceDefaultSpeechRate
    ) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = rate
        synthesizer.speak(utterance)
    }
}
