import Foundation
import FirebaseFirestore

struct GETUserRequest: FirestoreRequest {
    
    let collection = "users"
    let filter: Filter?
    
    init(userID: String) {
        filter = .whereField(FieldPath.documentID(), isEqualTo: userID)
    }
}

extension VPUser: FirestoreData {
    
    init?(id: String, data: [String : Any]) {
        self.init(
            id: id,
            favoriteEvents: data["favoriteEvents"] as? [String] ?? []
        )
    }
}
