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
        FlowStack($coordinator.routes, withNavigation: true) {
            HomeView(viewModel: coordinator.makeHomeViewModel())
                .flowDestination(for: Screen.self) { screen in
                    switch screen {
                    case .category:
                        Color.red
                            .navigationBar(
                                configuration: .init(
                                    leadingItems: [
                                        BackNavigationBarItemButton(action: { coordinator.routes.pop() })
                                    ],
                                    isBackgroundHidden: false
                                )
                            )
                    }
                }
        }
    }
}
