import SwiftUI
import FlowStacks
import BackdoorPanel

struct AppCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        FlowStack($coordinator.routes, withNavigation: true) {
            TabBarView(tabs: coordinator.tabs)
                .flowDestination(for: Screen.self) { screen in
                    switch screen {
                    case let .backdoor(coordinator):
                        BackdoorCoordinatorView(coordinator: coordinator)
                    }
                }
        }
        .overlay(alignment: .top) { backdoorView }
        .onFirstAppear(coordinator.onFirstAppear)
    }
}

// MARK: - Private

private extension AppCoordinatorView {
    
    var backdoorView: some View {
        Color.red
            .opacity(0.25)
            .frame(width: 50.0, height: 50.0)
            .onTapGesture(perform: coordinator.onBackdoor)
    }
}

// MARK: - Preview

#Preview {
    AppCoordinatorView(coordinator: .preiview)
}
