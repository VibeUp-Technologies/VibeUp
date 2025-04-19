import SwiftUI
import FlowStacks
import DesignSystem

public struct FavoritesCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: FavoritesCoordinator
    
    public init(coordinator: FavoritesCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        Router($coordinator.routes) { screen in
            switch screen {
            case let .favorites(viewModel):
                FavoritesView(viewModel: viewModel)
            }
        }
    }
}
