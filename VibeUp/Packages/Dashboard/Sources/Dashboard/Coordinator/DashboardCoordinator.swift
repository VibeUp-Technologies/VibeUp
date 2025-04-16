import Foundation
import FlowStacks

enum Screen: Hashable {
    case test
}

public final class DashboardCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    public init() { }
}

extension DashboardCoordinator {
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
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
