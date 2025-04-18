import Foundation
import Combine
import BackdoorPanelTypes

final class SignInViewModel: ObservableObject {
    
    @Published var email = "test1@gmail.com"
    @Published var password = "123456"
    
    private let authService: BackdoorAuthServicing
    
    private var signInCancelable: AnyCancellable?
    
    init(authService: BackdoorAuthServicing) {
        self.authService = authService
    }
}

extension SignInViewModel {
    
    func onSignIn() {
        let body = BackdoorSignIn(
            email: email,
            password: password
        )
        signInCancelable = authService.signIn(with: body)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
    }
}
