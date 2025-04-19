import Foundation
import FlowStacks

public final class ExploreCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        
        setupRoot()
    }
}

private extension ExploreCoordinator {
    
    func setupRoot() {
        routes = [.root(.map)]
    }
}
