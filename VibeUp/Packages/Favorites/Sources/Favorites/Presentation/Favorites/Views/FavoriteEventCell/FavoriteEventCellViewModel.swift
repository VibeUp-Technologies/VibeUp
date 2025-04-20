import Foundation
import Combine
import FavoriteTypes
import Formatter

final class FavoriteEventCellViewModel: Identifiable, ObservableObject {
    
    enum Event {
        case removeFromFavorites
    }
    
    let id: String
    let image: URL?
    let date: String
    let title: String
    let price: String
    let location: String
    let showDivider: Bool
    
    @Published private(set) var isLoading = false
    
    private let requestService: FavoritesRequestServicing
    private let onEvent: (Event) -> Void
    
    private var favoriteCancellable: AnyCancellable?
    
    init(
        dependency: Dependency,
        onEvent: @escaping (Event) -> Void
    ) {
        id = dependency.input.event.id
        image = URL(string: dependency.input.event.image)
        date = dependency.input.event.date.prettyFormatted(with: .format(.custom("dd MMM, HH:mm")))
        title = dependency.input.event.name
        price = Self.makePrice(for: dependency.input.event)
        location = dependency.input.event.location
        showDivider = dependency.input.showDivider
        requestService = dependency.services.requestService
        
        self.onEvent = onEvent
    }
}

// MARK: - Actions

extension FavoriteEventCellViewModel {
    
    func onFavorite() {
        isLoading = true
        favoriteCancellable = requestService.removeFromFavorites(id)
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] _ in
                    isLoading = false
                    
                    onEvent(.removeFromFavorites)
                }
            )
    }
}

// MARK: - Private

private extension FavoriteEventCellViewModel {
    
    static func makePrice(for event: FavoriteEvent) -> String {
        String(format: "%d%@ - %d%@", event.price.from, event.currencySymbol, event.price.to, event.currencySymbol)
    }
}
