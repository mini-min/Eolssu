import AVFoundation
import Speech
import SwiftUI

actor SpeechRecognizer: ObservableObject {
    
    @MainActor @Published var transcript: String = ""
    
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    init() {
        Task {
            await requestAuthorization()
        }
    }
    
    func startTranscribe() async throws {
        guard let recognizer, recognizer.isAvailable else { return }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw error
        }
        
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
            guard let self else { return }
            if let result {
                let transcription = result.bestTranscription.formattedString
                Task { @MainActor in
                    self.transcript = transcription
                }
            }
        }
    }
    
    func stopTranscribe() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        request?.endAudio()
        request = nil
    }
}

private extension SpeechRecognizer {
    func requestAuthorization() async {
        // Authorization Speech Recognizer
        let speechAuthStatus = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
        speechAuthStatus == .authorized
        ? print("음성 인식 권한이 허용되었습니다.")
        : print("음성 인식 권한이 허용되지 않았습니다.")
        
        // Authorization Audio Session
        let audioAuthStatus = await withCheckedContinuation { continuation in
            AVAudioSession.sharedInstance().requestRecordPermission { status in
                continuation.resume(returning: status)
            }
        }
        audioAuthStatus
        ? print("오디오 녹음 권한이 허용되었습니다.")
        : print("오디오 녹음 권한이 허용되지 않았습니다.")
    }
}
