import Foundation
import Combine
import DashboardTypes
import Formatter

final class UpcomingEventCellViewModel: Identifiable, ObservableObject {
    
    let id: String
    let image: URL?
    let month: String
    let day: String
    let title: String
    let price: String
    let location: String
    
    @Published private(set) var isLoading = false
    @Published private(set) var isFavorite: Bool
    @Published private(set) var isBookmarkShown = false
    
    private let requestService: DashboardRequestServicing
    
    private var favoriteCancellable: AnyCancellable?
    
    init(dependency: Dependency) {
        id = dependency.input.event.id
        image = URL(string: dependency.input.event.image)
        month = dependency.input.event.date.prettyFormatted(with: .format(.custom("MMM")))
        day = dependency.input.event.date.prettyFormatted(with: .format(.custom("d")))
        title = dependency.input.event.name
        price = Self.makePrice(for: dependency.input.event)
        isFavorite = dependency.input.event.isFavorite
        location = dependency.input.event.location
        requestService = dependency.services.requestService
        
        dependency.input.isAuthenticated.assign(to: &$isBookmarkShown)
    }
}

// MARK: - Actions

extension UpcomingEventCellViewModel {
    
    func onFavorite() {
        let request = isFavorite ? requestService.removeFromFavorites(id) : requestService.addToFavorites(id)
        
        isLoading = true
        favoriteCancellable = request
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] _ in
                    isFavorite.toggle()
                    
                    isLoading = false
                }
            )
    }
}

// MARK: - Private

private extension UpcomingEventCellViewModel {
    
    static func makePrice(for event: DashboardUpcomingEvent) -> String {
        String(format: "%d%@ - %d%@", event.price.from, event.currencySymbol, event.price.to, event.currencySymbol)
    }
}
