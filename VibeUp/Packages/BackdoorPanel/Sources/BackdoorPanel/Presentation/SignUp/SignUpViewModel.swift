import Foundation
import Combine
import BackdoorPanelTypes

final class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private let authService: BackdoorAuthServicing
    
    private var signUpCancelable: AnyCancellable?
    
    init(authService: BackdoorAuthServicing) {
        self.authService = authService
    }
}

extension SignUpViewModel {
    
    func onSignUp() {
        let body = BackdoorSignUp(
            email: email,
            password: password
        )
        signUpCancelable = authService.signUp(with: body)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
    }
}
