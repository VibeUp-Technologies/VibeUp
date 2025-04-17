import SwiftUI
import FlowStacks
import Dashboard

struct AppCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        FlowStack($coordinator.routes, withNavigation: true) {
            TabBarView(tabs: coordinator.tabs)
        }
    }
}

#Preview {
    AppCoordinatorView(coordinator: .preiview)
}
