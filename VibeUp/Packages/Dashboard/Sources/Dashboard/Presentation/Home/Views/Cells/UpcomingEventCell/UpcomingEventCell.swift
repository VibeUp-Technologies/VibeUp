import SwiftUI
import DesignSystem

struct UpcomingEventCell: View {
    
    @ObservedObject
    private var viewModel: UpcomingEventCellViewModel
    
    init(viewModel: UpcomingEventCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_1) {
            LazyImage(url: viewModel.image)
                .cornerRadius(Spacing.padding_1_5)
                .frame(height: 180.0)
                .overlay(alignment: .topLeading, content: { dateView })
                .overlay(alignment: .topTrailing, content: { bookmarkView })
            
            SFProText(text: viewModel.title, style: .sapphire, size: 18.0, isBold: true)
            SFProText(text: viewModel.price, style: .mediumSlateBlue, size: 18.0, isBold: true)
            
            HStack(spacing: Spacing.padding_0_5) {
                Resources.Image.mappin
                    .font(.system(size: 14.0))
                    .foregroundStyle(Resources.Colors.sapphire)
                
                SFProText(text: viewModel.location, style: .sapphire, size: 14.0)
            }
            
            Spacer()
        }
        .frame(width: 260.0)
    }
}

// MARK: - Private

private extension UpcomingEventCell {
    
    @ViewBuilder
    var dateView: some View {
        makeOverlayBackgroundView {
            VStack(spacing: .zero) {
                SFProText(text: viewModel.month, style: .sapphire, size: 14.0)
                SFProText(text: viewModel.day, style: .sapphire, size: 16.0, isBold: true)
            }
        }
    }
    
    @ViewBuilder
    var bookmarkView: some View {
        if viewModel.isBookmarkShown {
            makeOverlayBackgroundView {
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
            }
        }
    }
    
    func makeOverlayBackgroundView(content: () -> some View) -> some View {
        ZStack {
            Color.white
                .cornerRadius(Spacing.padding_1_5)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.padding_1_5)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                )
            
            content()
        }
        .frame(width: 40.0, height: 40.0)
        .padding(Spacing.padding_1)
    }
}
