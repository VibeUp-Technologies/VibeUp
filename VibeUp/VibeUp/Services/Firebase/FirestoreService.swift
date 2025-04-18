import Foundation
import Combine
import DashboardTypes
import FirebaseFirestore

protocol FirestoreData {
    
    init?(id: String, data: [String: Any])
}

protocol FirestoreRequest {
    
    var collection: String { get }
    var document: String { get }
    
    var body: [String: Any] { get }
}

extension FirestoreRequest {
    
    var document: String { "" }
    var body: [String: Any] { [:] }
}

protocol FirestoreServicing {
    
    func get<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error>
    func update(with request: FirestoreRequest) -> AnyPublisher<Void, Error>
}

final class FirestoreService {
    
    private lazy var firestore = Firestore.firestore()
    
    init() {
        print("🚀 FirebaseService initialized")
    }
    
    deinit {
        print("💥 FirebaseService deinitialized")
    }
}

// MARK: - FirestoreServicing

extension FirestoreService: FirestoreServicing {
 
    func get<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error> {
        Future { [unowned self] promise in
            firestore.collection(request.collection).getDocuments() { snapshot, error in
                if let error = error {
                    print("💥 Fetching rrror: \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("💥 No snapshot returned")
                    return
                }
                
                print("-->", snapshot.documents.compactMap { $0.data() })
                
                promise(.success(snapshot.documents.compactMap { .init(id: $0.documentID, data: $0.data()) }))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(with request: FirestoreRequest) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            firestore.collection(request.collection).document(request.document).updateData(request.body) { error in
                if let error = error {
                    print("💥 Fetching rrror: \(error)")
                    return
                }
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
