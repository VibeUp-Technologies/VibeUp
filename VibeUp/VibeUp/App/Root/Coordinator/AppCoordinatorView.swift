import SwiftUI
import FlowStacks
import Dashboard

struct AppCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: AppCoordinator
    
    private let tabFactory = TabFactrory()
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        FlowStack($coordinator.routes, withNavigation: true) {
            TabBarView(tabs: tabFactory.makeTabs())
        }
    }
}

private final class TabFactrory {
    
    private let viewModelFactory = ViewModelFactory()
    
    func makeTabs() -> [TabBarView.Tab] {
        [
            .home(viewModelFactory.makeDashboardCoordinator()),
            .explore,
            .saved,
            .profile
        ]
    }
}

private final class ViewModelFactory {
    
    func makeDashboardCoordinator() -> DashboardCoordinator {
        DashboardCoordinator()
    }
}

#Preview {
    AppCoordinatorView(coordinator: .preiview)
}
