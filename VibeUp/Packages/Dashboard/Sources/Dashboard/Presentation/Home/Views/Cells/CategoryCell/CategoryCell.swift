import SwiftUI
import DesignSystem

struct CategoryCell: View {
    
    private let viewModel: CategoryCellViewModel
    
    init(viewModel: CategoryCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
                .cornerRadius(Spacing.padding_1_5)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.padding_1_5)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                )
                .padding(.vertical, Spacing.padding_0_25)
            
            VStack(alignment: .leading, spacing: Spacing.padding_2) {
                Image(systemName: viewModel.image)
                    .font(.system(size: 22.0))
                    .foregroundStyle(Resources.Colors.sapphire)
                
                SFProText(text: viewModel.title.localized, style: .sapphire, size: 15.0)
            }
            .padding(.horizontal, Spacing.padding_2)
            .padding(.vertical, Spacing.padding_1_5)
        }
        .onTapGesture(perform: viewModel.onTap)
        .frame(minWidth: 100.0)
    }
}
