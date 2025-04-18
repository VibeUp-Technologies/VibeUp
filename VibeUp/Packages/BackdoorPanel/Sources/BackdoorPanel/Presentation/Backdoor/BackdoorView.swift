import SwiftUI
import DesignSystem

struct BackdoorView: View {
    
    private let signUpViewModel: SignUpViewModel
    private let logOutViewModel: LogOutViewModel
    
    init(
        signUpViewModel: SignUpViewModel,
        logOutViewModel: LogOutViewModel
    ) {
        self.signUpViewModel = signUpViewModel
        self.logOutViewModel = logOutViewModel
    }
    
    var body: some View {
        ScrollView {
            SignUpView(viewModel: signUpViewModel)
            LogOutView(viewModel: logOutViewModel)
        }
        .navigationBar(configuration: .init())
    }
}
