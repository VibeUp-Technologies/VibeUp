import SwiftUI
import FlowStacks
import DesignSystem

public struct BackdoorCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: BackdoorCoordinator
    
    public init(coordinator: BackdoorCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        Router($coordinator.routes) { screen in
            switch screen {
            case let .backdoor(viewModel):
                BackdoorView(viewModel: viewModel)
            }
        }
    }
}
