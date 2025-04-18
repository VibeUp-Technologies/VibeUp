import SwiftUI
import DesignSystem

struct SignInView: View {
    
    @ObservedObject
    private var viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SectionView(title: "Sign In") {
            VStack(alignment: .leading, spacing: Spacing.padding_1) {
                TextField("Email", text: $viewModel.email)
                TextField("Password", text: $viewModel.password)
                Button("Sign In", action: viewModel.onSignIn)
            }
            .padding(.horizontal, Spacing.padding_2)
        }
    }
}
