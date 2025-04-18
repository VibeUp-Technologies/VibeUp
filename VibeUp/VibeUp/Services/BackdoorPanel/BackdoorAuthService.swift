import BackdoorPanelTypes
import Combine

final class BackdoorAuthService {
    
    private let authService: AuthServicing
    
    init(authService: AuthServicing) {
        self.authService = authService
    }
}

// MARK: - BackdoorAuthServicing

extension BackdoorAuthService: BackdoorAuthServicing {
    
    func signIn(with body: BackdoorSignIn) -> AnyPublisher<Void, Error> {
        authService.signIn(email: body.email, password: body.password)
    }
    
    func signUp(with body: BackdoorSignUp) -> AnyPublisher<Void, Error> {
        authService.singUp(email: body.email, password: body.password)
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        authService.logOut()
    }
}
