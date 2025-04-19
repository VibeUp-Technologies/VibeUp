import Foundation
import FlowStacks

public final class BackdoorCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        
        setupRoot()
    }
}

private extension BackdoorCoordinator {
    
    func setupRoot() {
        routes = [.root(.backdoor(makeBackdoorViewModel()))]
    }
    
    func makeBackdoorViewModel() -> BackdoorViewModel {
        BackdoorViewModel(authService: dependency.services.authService)
    }
}
