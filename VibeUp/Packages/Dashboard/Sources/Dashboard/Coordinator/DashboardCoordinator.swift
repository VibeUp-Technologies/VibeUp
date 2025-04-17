import Foundation
import FlowStacks
import DashboardTypes

enum Screen: Hashable {
    case test
}

public extension DashboardCoordinator {
    
    struct Dependency {
        
        let services: Services
        
        public init(services: Services) {
            self.services = services
        }
    }
    
    struct Services {
        
        let requestService: DashboardRequestServicing
        
        public init(requestService: DashboardRequestServicing) {
            self.requestService = requestService
        }
    }
}

public final class DashboardCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension DashboardCoordinator {
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            dependency: .init(
                services: .init(
                    requestService: dependency.services.requestService
                )
            ),
            onEvent: { [weak self] event in
                guard let self else { return }
                
                switch event {
                case .test:
                    routes.push(.test)
                }
            }
        )
    }
}
