import SwiftUI

struct ContentView: View {
    
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            Text("Speech To Text")
                .font(.title)
                .padding()
            
            TextEditor(text: Binding(
                get: { speechRecognizer.transcript },
                set: { _ in }
            ))
            .frame(height: 200)
            .border(Color.gray)
            
            HStack {
                Button(action: {
                    Task {
                        do {
                            try await speechRecognizer.startTranscribe()
                        } catch {
                            print("Error starting transcription:", error)
                        }
                    }
                }) {
                    Text("Start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    Task { await speechRecognizer.stopTranscribe() }
                }) {
                    Text("Stop")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}
