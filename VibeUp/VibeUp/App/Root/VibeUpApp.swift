import SwiftUI

@main
struct VibeUpApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var delegate
    
    private let coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: coordinator)
        }
    }
}
