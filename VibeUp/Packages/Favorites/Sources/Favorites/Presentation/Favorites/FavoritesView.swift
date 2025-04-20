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
        SectionView(
            title: .localizable(.favoriteEventsTitle),
            content: { contentView }
        )
        .onAppear(perform: viewModel.onAppear)
        .onFirstAppear(viewModel.onFirstAppear)
    }
}

// MARK: - Private

private extension FavoritesView {
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.isAuthenticated {
            stateView
        } else {
            unauthenticatedView
        }
    }
    
    var unauthenticatedView: some View {
        FullScreenMessageView(
            buttons: [
                .init(title: "Sign In", onAction: { }),
                .init(title: "Sign Up", onAction: { })
            ]
        )
    }
    
    @ViewBuilder
    var stateView: some View {
        switch viewModel.state {
        case .loading:
            Color.red
        case let .loaded(viewModels):
            makeDataView(viewModels)
        case .error:
            Color.blue
        }
    }
    
    func makeDataView(_ viewModels: [FavoriteEventCellViewModel]) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: Spacing.padding_2) {
                ForEach(viewModels, content: FavoriteEventCell.init)
            }
            .padding(.horizontal, Spacing.padding_2)
        }
    }
}
