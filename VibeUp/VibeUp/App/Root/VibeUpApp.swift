import SwiftUI

@main
struct VibeUpApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    private let appComponents = AppComponents()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                coordinator: AppCoordinator(
                    appComponents: appComponents
                )
            )
        }
    }
}
