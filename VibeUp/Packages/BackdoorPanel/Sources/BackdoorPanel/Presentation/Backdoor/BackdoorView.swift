import SwiftUI
import DesignSystem

struct BackdoorView: View {
    
    private let viewModel: BackdoorViewModel
    
    init(viewModel: BackdoorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            SignInView(viewModel: viewModel.signInViewModel)
            SignUpView(viewModel: viewModel.signUpViewModel)
            LogOutView(viewModel: viewModel.logOutViewModel)
        }
        .navigationBar(configuration: .init())
    }
}
