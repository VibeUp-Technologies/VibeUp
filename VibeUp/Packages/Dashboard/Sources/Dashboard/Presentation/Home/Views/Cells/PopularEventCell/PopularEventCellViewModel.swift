import Foundation
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
    
    @Published private(set) var isFavorite: Bool
    @Published private(set) var isBookmarkShown = false
    
    init(dependency: Dependency) {
        id = dependency.input.event.id
        image = URL(string: dependency.input.event.image)
        date = dependency.input.event.date.prettyFormatted(with: .format(.custom("dd MMM, HH:mm")))
        title = dependency.input.event.name
        price = Self.makePrice(for: dependency.input.event)
        isFavorite = false
        location = dependency.input.event.location
        showDivider = dependency.input.showDivider
        
        dependency.input.isAuthenticated.assign(to: &$isBookmarkShown)
    }
}

extension PopularEventCellViewModel {
    
    func onFavorite() {
        isFavorite.toggle()
    }
}

// MARK: - Private

private extension PopularEventCellViewModel {
    
    static func makePrice(for event: DashboardUpcomingEvent) -> String {
        String(format: "%d%@ - %d%@", event.price.from, event.currencySymbol, event.price.to, event.currencySymbol)
    }
}
