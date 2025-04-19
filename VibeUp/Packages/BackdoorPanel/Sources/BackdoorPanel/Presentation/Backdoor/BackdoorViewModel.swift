import Foundation
import Combine
import BackdoorPanelTypes

final class BackdoorViewModel {
    
    lazy var signInViewModel: SignInViewModel = {
        SignInViewModel(authService: authService)
    }()
    
    lazy var signUpViewModel: SignUpViewModel = {
        SignUpViewModel(authService: authService)
    }()
    
    lazy var logOutViewModel: LogOutViewModel = {
        LogOutViewModel(authService: authService)
    }()
    
    private let authService: BackdoorAuthServicing
    
    init(authService: BackdoorAuthServicing) {
        self.authService = authService
    }
}
