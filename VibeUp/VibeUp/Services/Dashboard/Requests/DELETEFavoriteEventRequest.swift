import Foundation
import FirebaseFirestore
import DashboardTypes

struct DELETEFavoriteEventRequest: FirestoreRequest {
    
    let collection = "favorites"
    let document: String
    let body: [String : Any]
    
    init(userId: String, eventId: String) {
        self.document = userId
        
        self.body = ["events": FieldValue.arrayRemove([eventId])]
    }
}
