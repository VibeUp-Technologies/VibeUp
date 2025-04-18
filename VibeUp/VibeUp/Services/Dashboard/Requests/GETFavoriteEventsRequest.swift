import Foundation
import DashboardTypes

struct GETFavoriteEventsRequest: FirestoreRequest {
    
    let collection = "favorites"
}

struct Favorite: FirestoreData {
    
    let id: String
    let events: [String]
    
    init(id: String, events: [String]) {
        self.id = id
        self.events = events
    }
    
    init?(id: String, data: [String : Any]) {
        self.id = id
        self.events = (data["events"] as? [String]) ?? []
    }
}
