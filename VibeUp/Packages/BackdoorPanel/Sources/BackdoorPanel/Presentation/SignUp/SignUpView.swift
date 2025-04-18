import SwiftUI
import DesignSystem

struct SignUpView: View {
    
    @ObservedObject
    private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SectionView(title: "Sign Up") {
            VStack(alignment: .leading, spacing: Spacing.padding_1) {
                TextField("Email", text: $viewModel.email)
                TextField("Password", text: $viewModel.password)
                Button("Sign Up", action: viewModel.onSignUp)
            }
            .padding(.horizontal, Spacing.padding_2)
        }
    }
}
