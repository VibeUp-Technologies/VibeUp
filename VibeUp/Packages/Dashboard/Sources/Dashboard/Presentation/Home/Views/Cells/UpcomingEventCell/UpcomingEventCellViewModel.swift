import Foundation
import DashboardTypes
import Formatter

struct UpcomingEventCellViewModel: Identifiable {
    
    let id: String
    let image: URL?
    let month: String
    let day: String
    let title: String
    let price: String
    let location: String
    
    init(event: DashboardUpcomingEvent) {
        id = event.id
        image = URL(string: event.image)
        month = event.date.prettyFormatted(with: .format(.custom("MMM")))
        day = event.date.prettyFormatted(with: .format(.custom("d")))
        title = event.name
        price = Self.makePrice(for: event)
        location = event.location
    }
}

// MARK: - Private

private extension UpcomingEventCellViewModel {
    
    static func makePrice(for event: DashboardUpcomingEvent) -> String {
        String(format: "%d%@ - %d%@", event.price.from, event.currencySymbol, event.price.to, event.currencySymbol)
    }
}
