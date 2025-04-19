import Foundation
import FlowStacks
import BackdoorPanel
import Dashboard
import Explore

final class AppCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let appComponents: AppComponents
    
    init(appComponents: AppComponents) {
        self.appComponents = appComponents
        
        setupRoot()
    }
}

// MARK: - Actions

extension AppCoordinator {
    
    func onFirstAppear() {
        appComponents.authService.setup()
    }
    
    func onBackdoor() {
        routes.presentSheet(.backdoor(makeBackdoorCoordinates()))
    }
}

// MARK: - Private

private extension AppCoordinator {
    
    func setupRoot() {
        let tabs: [TabBarView.Tab] = [
            .home(makeDashboardCoordinator()),
            .explore(makeExploreCoordinator()),
            .saved,
            .profile
        ]
        routes = [.root(.dashboard(tabs))]
    }
    
    func makeDashboardCoordinator() -> DashboardCoordinator {
        DashboardCoordinator(
            dependency: .init(
                input: .init(
                    isAuthenticated: appComponents.authService.isAuthenticated
                ),
                services: .init(
                    requestService: DasboardRequestService(
                        authService: appComponents.authService,
                        firestoreService: appComponents.firestoreService
                    )
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
                    authService: BackdoorAuthService(
                        authService: appComponents.authService
                    )
                )
            )
        )
    }
}
