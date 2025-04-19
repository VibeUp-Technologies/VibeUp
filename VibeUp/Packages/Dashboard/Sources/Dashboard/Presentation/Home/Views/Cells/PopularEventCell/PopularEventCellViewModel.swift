import Foundation
import Combine
import DashboardTypes
import Formatter

final class PopularEventCellViewModel: Identifiable, ObservableObject {
    
    let id: String
    let image: URL?
    let date: String
    let title: String
    let price: String
    let location: String
    let showDivider: Bool
    
    @Published private(set) var isLoading = false
    @Published private(set) var isFavorite: Bool
    @Published private(set) var isBookmarkShown = false
    
    private let requestService: DashboardRequestServicing
    
    private var favoriteCancellable: AnyCancellable?
    
    init(dependency: Dependency) {
        id = dependency.input.event.id
        image = URL(string: dependency.input.event.image)
        date = dependency.input.event.date.prettyFormatted(with: .format(.custom("dd MMM, HH:mm")))
        title = dependency.input.event.name
        price = Self.makePrice(for: dependency.input.event)
        isFavorite = dependency.input.event.isFavorite
        location = dependency.input.event.location
        showDivider = dependency.input.showDivider
        requestService = dependency.services.requestService
        
        dependency.input.isAuthenticated.assign(to: &$isBookmarkShown)
    }
}

// MARK: - Actions

extension PopularEventCellViewModel {
    
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

private extension PopularEventCellViewModel {
    
    static func makePrice(for event: DashboardUpcomingEvent) -> String {
        String(format: "%d%@ - %d%@", event.price.from, event.currencySymbol, event.price.to, event.currencySymbol)
    }
}
