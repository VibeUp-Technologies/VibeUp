import Foundation

struct POSTUserRequest: FirestoreRequest {
    
    let collection = "users"
    let document: String
    let body: [String: Any]
    
    init(body: VPUser) {
        self.document = body.id
        self.body = [
            "favoriteEvents": []
        ]
    }
}
