import SwiftUI
import DesignSystem

struct FavoriteEventCell: View {
    
    @ObservedObject
    private var viewModel: FavoriteEventCellViewModel
    
    init(viewModel: FavoriteEventCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LightEventCell(
            image: viewModel.image,
            title: viewModel.title,
            date: viewModel.date,
            location: viewModel.location,
            price: viewModel.price,
            showDivider: viewModel.showDivider,
            isBookmarkShown: true,
            isFavorite: true,
            isLoading: viewModel.isLoading,
            onFavorite: viewModel.onFavorite
        )
    }
}
