import Foundation
import Combine
import FavoriteTypes

final class FavoritesViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded([FavoriteEventCellViewModel])
        case error
    }
    
    @Published private(set) var isAuthenticated = false
    @Published private(set) var state: State = .loading
    
    private let dependency: Dependency
    
    private var favoritesCancelabel: AnyCancellable?
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

// MARK: - Actions

extension FavoritesViewModel {
    
    func onAppear() {
        fetchFavoritres()
    }
    
    func onFirstAppear() {
        setupSubscriptions()
    }
}

// MARK: - Private

private extension FavoritesViewModel {
    
    func setupSubscriptions() {
        dependency.input.isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func fetchFavoritres() {
        favoritesCancelabel = dependency.services.requestSetvice.fetchFavoriteEvents()
            .sink(
                receiveCompletion: { [unowned self] completion in
                    guard case let .failure(error) = completion else { return }
                    
                    state = .error
                },
                receiveValue: { [unowned self] events in
                    state = .loaded(
                        events.enumerated().map { index, value in
                            makeFavoriteEventCellViewModel(
                                favoriteEvent: value,
                                showDivider: index != events.endIndex - 1
                            )
                        }
                    )
                }
            )
    }
    
    func makeFavoriteEventCellViewModel(
        favoriteEvent: FavoriteEvent,
        showDivider: Bool
    ) -> FavoriteEventCellViewModel {
        FavoriteEventCellViewModel(
            dependency: .init(
                input: .init(
                    event: favoriteEvent,
                    showDivider: showDivider
                ),
                services: .init(
                    requestService: dependency.services.requestSetvice
                )
            ),
            onEvent: { [weak self] event in
                guard let self else { return }
                
                switch event {
                case .removeFromFavorites:
                    state.remove(by: favoriteEvent.id)
                }
            }
        )
    }
}

// MARK: - State

private extension FavoritesViewModel.State {
    
    private var data: [FavoriteEventCellViewModel] {
        if case .loaded(let data) = self { data } else { [] }
    }
    
    mutating
    func remove(by id: String) {
        var data = data
        data.removeAll(where: { $0.id == id })
        
        self = .loaded(data)
    }
}

