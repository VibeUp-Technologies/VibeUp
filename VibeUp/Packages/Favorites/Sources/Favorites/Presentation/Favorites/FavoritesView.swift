import SwiftUI
import MapKit
import DesignSystem

struct FavoritesView: View {
    
    @ObservedObject
    private var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            SectionView(
                title: "Favorite Events",
                content: {
                    LazyVStack(alignment: .leading, spacing: Spacing.padding_2) {
                        ForEach(viewModel.favoriteEventsViewModels.indices, id: \.self) { index in
                            SFProText(text: viewModel.favoriteEventsViewModels[index], style: .sapphire)
                        }
                    }
                    .padding(.horizontal, Spacing.padding_2)
                }
            )
        }
        .onAppear(perform: viewModel.onAppear)
    }
}
