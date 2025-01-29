import AVFoundation
import Speech
import SwiftUI

actor SpeechRecognizer: ObservableObject {
    
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private var recognitionTask: SFSpeechRecognitionTask?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private let audioEngine = AVAudioEngine()
    
    @MainActor @Published var transcript: String = ""
        
    func startTranscribe() async throws {
        guard let recognizer, recognizer.isAvailable else { return }
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.addsPunctuation = true
        self.request = request
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        self.audioEngine.prepare()
        try self.audioEngine.start()
        
        self.recognitionTask = recognizer.recognitionTask(
            with: request
        ) { [weak self] result, error in
            if let result {
                let message = result.bestTranscription.formattedString
                self?.transcribe(message)
            }
        }
    }
    
    func stopTranscribe() {
        audioEngine.stop()
        recognitionTask?.cancel()
        recognitionTask = nil
        request?.endAudio()
        request = nil
    }
}

private extension SpeechRecognizer {
    nonisolated func transcribe(_ message: String) {
        Task { @MainActor in
            self.transcript = message
        }
    }
}
