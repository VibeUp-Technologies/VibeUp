import Foundation
import FlowStacks
import BackdoorPanel
import Dashboard
import Explore

final class AppCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    lazy var tabs: [TabBarView.Tab] = {
        [
            .home(makeDashboardCoordinator()),
            .explore(makeExploreCoordinator()),
            .saved,
            .profile
        ]
    }()
    
    private let authService = AuthService()
    private let firestoreService = FirestoreService()
}

// MARK: - Actions

extension AppCoordinator {
    
    func onBackdoor() {
        routes.presentSheet(.backdoor(makeBackdoorCoordinates()))
    }
}

// MARK: - Private

private extension AppCoordinator {
    
    func makeDashboardCoordinator() -> DashboardCoordinator {
        DashboardCoordinator(
            dependency: .init(
                input: .init(
                    isAuthenticated: authService.isAuthenticated
                ),
                services: .init(
                    requestService: DasboardRequestService(firestoreService: firestoreService)
                )
            )
        )
    }
    
    func makeExploreCoordinator() -> ExploreCoordinator {
        ExploreCoordinator(dependency: .init(services: .init()))
    }
    
    func makeBackdoorCoordinates() -> BackdoorCoordinator {
        BackdoorCoordinator(
            dependency: .init(
                services: .init(
                    authService: BackdoorAuthService(authService: authService)
                )
            )
        )
    }
}
