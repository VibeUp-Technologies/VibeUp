import SwiftUI
import FlowStacks
import Dashboard

struct AppCoordinatorView: View {
    
    @ObservedObject
    private var appCoordinator: AppCoordinator
    
    private let tabFactory = TabFactrory()
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    var body: some View {
        TabBarView(tabs: tabFactory.makeTabs())
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
    AppCoordinatorView(appCoordinator: .preiview)
}
