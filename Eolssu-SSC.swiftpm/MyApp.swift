import SwiftUI

@main
struct MyApp: App {
    
    init() {
        FontManager.registerFont(name: "goverment_identity", fileExtension: "ttf")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
