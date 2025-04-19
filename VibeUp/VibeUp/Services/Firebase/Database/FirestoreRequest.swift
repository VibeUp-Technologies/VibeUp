import FirebaseFirestore

protocol FirestoreRequest {
    
    var collection: String { get }
    var document: String { get }
    var filter: Filter? { get }
    
    var body: [String: Any] { get }
}

extension FirestoreRequest {
    
    var document: String { "" }
    var filter: Filter? { nil }
    var body: [String: Any] { [:] }
}
