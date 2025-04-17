import Foundation
import Combine
import DashboardTypes
import FirebaseFirestore

protocol FirestoreData {
    
    init?(id: String, data: [String: Any])
}

protocol FirestoreRequest {
    
    var path: String { get }
}

protocol FirestoreServicing {
    func fetch<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error>
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
 
    func fetch<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error> {
        Future { [unowned self] promise in
            firestore.collection(request.path).getDocuments() { snapshot, error in
                if let error = error {
                    print("💥 Error fetching categories: \(error)")
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
}
