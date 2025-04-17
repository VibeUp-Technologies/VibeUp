import Foundation
import FlowStacks
import Dashboard

enum Screen: Hashable {
    case dashboard
}

final class AppCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    lazy var tabs: [TabBarView.Tab] = {
        [
            .home(makeDashboardCoordinator()),
            .explore,
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
}
