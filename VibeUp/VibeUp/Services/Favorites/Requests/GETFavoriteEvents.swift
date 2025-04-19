import Foundation
import FirebaseFirestore
import FavoriteTypes

struct GETFavoriteEvents: FirestoreRequest {
    
    let collection = "events"
    let filter: Filter?
    
    init(ids: [String]) {
        filter = .whereField(FieldPath.documentID(), in: ids)
    }
}

extension FavoriteEvent: FirestoreData {
    
    init?(id: String, data: [String: Any]) {
        self.init(
            id: id,
            date: (data["date"] as? Timestamp)?.dateValue() ?? Date(),
            image: data["image"] as? String ?? "",
            location: data["location"] as? String ?? "",
            name: data["name"] as? String ?? "",
            price: .init(data: data["price"] as? [String: Any] ?? [:]),
            currencySymbol: data["currencySymbol"] as? String ?? ""
        )
    }
}

private extension FavoriteEvent.Price {
    
    init(data: [String: Any]) {
        self.init(
            from: data["from"] as? Int ?? .zero,
            to: data["to"] as? Int ?? .zero
        )
    }
}
