import Foundation
import DashboardTypes
import Formatter

struct PopularEventCellViewModel: Identifiable {
    
    let id: String
    let image: URL?
    let date: String
    let title: String
    let price: String
    let location: String
    let showDivider: Bool
    
    init(
        event: DashboardUpcomingEvent,
        showDivider: Bool
    ) {
        id = event.id
        image = URL(string: event.image)
        date = event.date.prettyFormatted(with: .format(.custom("dd MMM, HH:mm")))
        title = event.name
        price = Self.makePrice(for: event)
        location = event.location
        
        self.showDivider = showDivider
    }
}

// MARK: - Private

private extension PopularEventCellViewModel {
    
    static func makePrice(for event: DashboardUpcomingEvent) -> String {
        String(format: "%d%@ - %d%@", event.price.from, event.currencySymbol, event.price.to, event.currencySymbol)
    }
}
