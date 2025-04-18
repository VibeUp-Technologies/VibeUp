import SwiftUI
import DesignSystem

struct BackdoorView: View {
    
    private let signInViewModel: SignInViewModel
    private let signUpViewModel: SignUpViewModel
    private let logOutViewModel: LogOutViewModel
    
    init(
        signInViewModel: SignInViewModel,
        signUpViewModel: SignUpViewModel,
        logOutViewModel: LogOutViewModel
    ) {
        self.signInViewModel = signInViewModel
        self.signUpViewModel = signUpViewModel
        self.logOutViewModel = logOutViewModel
    }
    
    var body: some View {
        ScrollView {
            SignInView(viewModel: signInViewModel)
            SignUpView(viewModel: signUpViewModel)
            LogOutView(viewModel: logOutViewModel)
        }
        .navigationBar(configuration: .init())
    }
}
