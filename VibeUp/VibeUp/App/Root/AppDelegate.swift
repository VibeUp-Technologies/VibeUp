import UIKit
import Firebase
import SDWebImage

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        configurateGoogleServices()
        configurateSDWebImage()
        
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
    
    func configurateSDWebImage() {
        let cache = SDImageCache(namespace: "com.vibeUp.sdwebimage.cache")
        cache.config.maxMemoryCost = 100 * 1024 * 1024 // 100MB memory
        cache.config.maxDiskSize = 50 * 1024 * 1024 // 50MB disk
        SDImageCachesManager.shared.addCache(cache)
        
        SDWebImageManager.defaultImageCache = SDImageCachesManager.shared
    }
}
