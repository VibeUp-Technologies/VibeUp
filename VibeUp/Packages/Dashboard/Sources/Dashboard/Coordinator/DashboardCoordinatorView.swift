import SwiftUI
import FlowStacks
import DesignSystem

public struct DashboardCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: DashboardCoordinator
    
    public init(coordinator: DashboardCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        Router($coordinator.routes) { screen in
            switch screen {
            case let .home(viewModel):
                HomeView(viewModel: viewModel)
            case .category:
                Color.red
            }
        }
    }
}
