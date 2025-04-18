import SwiftUI
import DesignSystem

struct LogOutView: View {
    
    @ObservedObject
    private var viewModel: LogOutViewModel
    
    init(viewModel: LogOutViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SectionView(title: "Log Out") {
            Button("Log Out", action: viewModel.onLogOut)
                .padding(.horizontal, Spacing.padding_2)
        }
    }
}
