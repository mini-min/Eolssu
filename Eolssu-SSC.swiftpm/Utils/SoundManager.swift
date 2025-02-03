import AVFoundation
import SwiftUI

final class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer? 
    
    private init() {}
    
    func playSound(name fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "wav") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Audio player error: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}
