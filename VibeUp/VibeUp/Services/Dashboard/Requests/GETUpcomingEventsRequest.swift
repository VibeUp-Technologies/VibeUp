import Foundation
import FirebaseCore
import DashboardTypes

struct GETUpcomingEventsRequest: FirestoreRequest {
    
    let collection = "events"
}

extension DashboardUpcomingEvent: FirestoreData {
    
    init?(id: String, data: [String: Any]) {
        self.init(
            id: id,
            date: (data["date"] as? Timestamp)?.dateValue() ?? Date(),
            image: data["image"] as? String ?? "",
            location: data["location"] as? String ?? "",
            name: data["name"] as? String ?? "",
            price: .init(data: data["price"] as? [String: Any] ?? [:]),
            currencySymbol:  data["currencySymbol"] as? String ?? "",
            isFavorite: false
        )
    }
}

private extension DashboardUpcomingEvent.Price {
    
    init(data: [String: Any]) {
        self.init(
            from: data["from"] as? Int ?? .zero,
            to: data["to"] as? Int ?? .zero
        )
    }
}
