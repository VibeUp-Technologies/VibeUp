import UIKit
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        configurateGoogleServices()
        
        return true
    }
}

private extension AppDelegate {
    
    func configurateGoogleServices() {
        guard
            let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: path)
        else {
            return
        }
        
        FirebaseApp.configure(options: options)
    }
}
