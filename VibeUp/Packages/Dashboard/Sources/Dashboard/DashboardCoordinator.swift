import Foundation
import FlowStacks

enum Screen: Hashable {
    
}

public final class DashboardCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    public init() { }
}
