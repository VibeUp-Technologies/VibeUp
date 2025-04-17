import Foundation
import FlowStacks
import Dashboard
import Explore

enum Screen: Hashable {
    case dashboard
}

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
    
    private let firestoreService = FirestoreService()
}

private extension AppCoordinator {
    
    func makeDashboardCoordinator() -> DashboardCoordinator {
        DashboardCoordinator(
            dependency: .init(
                services: .init(
                    requestService: DasboardRequestService(firestoreService: firestoreService)
                )
            )
        )
    }
    
    func makeExploreCoordinator() -> ExploreCoordinator {
        ExploreCoordinator(dependency: .init(services: .init()))
    }
}
