import SwiftUI

@main
struct MyApp: App {
    
    init() {
        /// Set up Font
        FontManager.registerFont(name: "goverment_identity", fileExtension: "ttf")
        
        /// Set up Segmented Control
        let appearance = UISegmentedControl.appearance()
        appearance.selectedSegmentTintColor = UIColor.white
        appearance.backgroundColor = UIColor.init(red: 233/255, green: 236/255, blue: 239/255, alpha: 0.5)
        appearance.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.init(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0),
                    .font: UIFont.myFont(size: 15)
            ],
            for: .normal
        )        
        appearance.setTitleTextAttributes(
            [
                .foregroundColor: UIColor.init(red: 177/255, green: 124/255, blue: 93/255, alpha: 1.0),                 
                    .font: UIFont.myFont(size: 15)
            ],
            for: .selected
        )
    }
    
    var body: some Scene {
        WindowGroup {
            InitialView()
        }
    }
}
