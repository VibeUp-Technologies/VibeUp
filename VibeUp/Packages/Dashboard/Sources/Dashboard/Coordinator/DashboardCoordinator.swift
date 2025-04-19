import Foundation
import FlowStacks

public final class DashboardCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        
        setupRoot()
    }
}

// MARK: - Private

private extension DashboardCoordinator {
    
    func setupRoot() {
        routes = [.root(.home(makeHomeViewModel()))]
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            dependency: .init(
                input: .init(
                    isAuthenticated: dependency.input.isAuthenticated
                ),
                services: .init(
                    requestService: dependency.services.requestService
                )
            ),
            onEvent: { [weak self] event in
                guard let self else { return }
                
                switch event {
                case let .category(category):
                    routes.push(.category)
                }
            }
        )
    }
}
