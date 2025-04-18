import Foundation
import FirebaseFirestore
import DashboardTypes

struct PUTFavoriteEventRequest: FirestoreRequest {
    
    let collection = "favorites"
    let document: String
    let body: [String : Any]
    
    init(userId: String, eventId: String) {
        self.document = userId
        
        self.body = ["events": FieldValue.arrayUnion([eventId])]
    }
}
