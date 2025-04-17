import Foundation
import FlowStacks

enum Screen: Hashable {
    
}

public extension ExploreCoordinator {
    
    struct Dependency {
        
        let services: Services
        
        public init(services: Services) {
            self.services = services
        }
    }
    
    struct Services {
        
        public init() { }
    }
}

public final class ExploreCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension ExploreCoordinator {
    
    
}
