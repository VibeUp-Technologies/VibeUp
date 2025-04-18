import SwiftUI
import DesignSystem

struct BackdoorView: View {
    
    private let signUpViewModel: SignUpViewModel
    
    init(signUpViewModel: SignUpViewModel) {
        self.signUpViewModel = signUpViewModel
    }
    
    var body: some View {
        ScrollView {
            SignUpView(viewModel: signUpViewModel)
        }
        .navigationBar(configuration: .init())
    }
}
