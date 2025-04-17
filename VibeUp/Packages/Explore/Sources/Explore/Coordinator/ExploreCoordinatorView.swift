import SwiftUI
import FlowStacks
import DesignSystem

public struct ExploreCoordinatorView: View {
    
    @ObservedObject
    private var coordinator: ExploreCoordinator
    
    public init(coordinator: ExploreCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        FlowStack($coordinator.routes) {
            MapView()
        }
    }
}
