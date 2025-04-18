import SwiftUI
import DesignSystem

struct PopularEventCell: View {
    
    @ObservedObject
    private var viewModel: PopularEventCellViewModel
    
    init(viewModel: PopularEventCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_1) {
            HStack(spacing: Spacing.padding_2) {
                imageView
                infoView
                Spacer()
                bookmarkView
            }
            if viewModel.showDivider {
                Divider()
            }
        }
    }
}

// MARK: - Private

private extension PopularEventCell {
    
    var imageView: some View {
        LazyImage(url: viewModel.image)
            .cornerRadius(Spacing.padding_1_5)
            .frame(width: 100.0, height: 100.0)
    }
    
    var infoView: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_1) {
            SFProText(text: viewModel.title, style: .sapphire, size: 16.0, isBold: true)
            
            VStack(alignment: .leading, spacing: Spacing.padding_0_5) {
                SFProText(text: viewModel.date, style: .sapphire, size: 14.0)
                SFProText(text: viewModel.location, style: .sapphire, size: 14.0)
                SFProText(text: viewModel.price, style: .mediumSlateBlue, size: 14.0, isBold: true)
            }
        }
    }
    
    @ViewBuilder
    var bookmarkView: some View {
        if viewModel.isBookmarkShown {
            Button(
                action: viewModel.onFavorite,
                label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            viewModel.isFavorite ? Resources.Image.bookmarkFill : Resources.Image.bookmark
                        }
                    }
                    .font(.system(size: 18.0))
                    .foregroundStyle(Resources.Colors.sapphire)
                }
            )
            .padding(.trailing, Spacing.padding_1)
        }
    }
}
