import UIKit
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey : Any]?
    
    private func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil
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
