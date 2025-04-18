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
        FlowStack($coordinator.routes, withNavigation: true) {
            BackdoorView(
                signInViewModel: coordinator.makeSignInViewModel(),
                signUpViewModel: coordinator.makeSignUpViewModel(),
                logOutViewModel: coordinator.makeLogOutViewModel()
            )
        }
    }
}
