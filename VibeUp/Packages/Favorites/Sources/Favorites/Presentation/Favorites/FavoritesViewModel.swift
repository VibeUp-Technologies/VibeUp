import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    
    @Published private(set) var favoriteEventsViewModels: [String] = []
    
    private let dependency: Dependency
    
    private var favoritesCancelabel: AnyCancellable?
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

// MARK: - Actions

extension FavoritesViewModel {
    
    func onFirstAppear() {
        fetchFavoritres()
    }
}

// MARK: - Private

private extension FavoritesViewModel {
    
    func fetchFavoritres() {
        favoritesCancelabel = dependency.services.requestSetvice.fetchFavoriteEvents()
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] events in
                    favoriteEventsViewModels = events.map(\.id)
                }
            )
    }
}

