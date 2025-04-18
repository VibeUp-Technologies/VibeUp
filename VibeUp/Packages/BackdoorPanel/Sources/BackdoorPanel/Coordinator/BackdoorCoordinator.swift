import Foundation
import FlowStacks

public final class BackdoorCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension BackdoorCoordinator {
    
    func makeSignUpViewModel() -> SignUpViewModel {
        SignUpViewModel(authService: dependency.services.authService)
    }
    
    func makeLogOutViewModel() -> LogOutViewModel {
        LogOutViewModel(authService: dependency.services.authService)
    }
}

// TODO: - Move to FlowStacks

extension BackdoorCoordinator: Identifiable, Hashable {
    
    var identifier: String {
        UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: BackdoorCoordinator, rhs: BackdoorCoordinator) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
