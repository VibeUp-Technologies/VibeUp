import Foundation
import FlowStacks

enum Screen: Hashable {
    case dashboard
}

final class AppCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = [.cover(.dashboard)]
    
}
