import SwiftUI
import DesignSystem

struct PopularEventCell: View {
    
    private let viewModel: PopularEventCellViewModel
    
    init(viewModel: PopularEventCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_2) {
            HStack(spacing: Spacing.padding_2) {
                LazyImage(url: viewModel.image)
                    .cornerRadius(Spacing.padding_1_5)
                    .frame(width: 100.0, height: 100.0)
                
                VStack(alignment: .leading, spacing: Spacing.padding_1) {
                    SFProText(text: viewModel.title, style: .sapphire, size: 16.0, isBold: true)
                    
                    VStack(alignment: .leading, spacing: Spacing.padding_0_5) {
                        SFProText(text: viewModel.date, style: .sapphire, size: 14.0)
                        SFProText(text: viewModel.location, style: .sapphire, size: 14.0)
                        SFProText(text: viewModel.price, style: .mediumSlateBlue, size: 14.0, isBold: true)
                    }
                }
                
                // TODO: - Add bookmark
                
                Spacer()
            }
            if viewModel.showDivider {
                Divider()
            }
        }
    }
}
