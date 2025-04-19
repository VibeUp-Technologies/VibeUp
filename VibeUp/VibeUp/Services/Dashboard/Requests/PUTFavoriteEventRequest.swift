import Foundation
import FirebaseFirestore
import DashboardTypes

struct PUTFavoriteEventRequest: FirestoreRequest {
    
    let collection = "users"
    let document: String
    let body: [String : Any]
    
    init(
        userID: String,
        eventID: String
    ) {
        self.document = userID
        
        self.body = ["favoriteEvents": FieldValue.arrayUnion([eventID])]
    }
}
