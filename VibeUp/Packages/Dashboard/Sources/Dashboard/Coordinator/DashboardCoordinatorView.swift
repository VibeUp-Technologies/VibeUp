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
        HomeView(viewModel: coordinator.viewModelFactory.makeHomeViewModel())
    }
}
