import Foundation
import Combine
import DashboardTypes
import FirebaseFirestore

protocol FirestoreServicing {
    func fetchCategories() -> AnyPublisher<[DashboardTypes.Category], Error>
}

final class FirestoreService: FirestoreServicing {
    
    private lazy var firestore = Firestore.firestore()
    
    init() {
        print("🚀 FirebaseService initialized")
    }
    
    deinit {
        print("💥 FirebaseService deinitialized")
    }
    
    func fetchCategories() -> AnyPublisher<[DashboardTypes.Category], Error> {
        Future<[DashboardTypes.Category], Error> { [unowned self] promise in
            firestore.collection("categories").getDocuments() { (snapshot, error) in
                if let error = error {
                    print("💥 Error fetching categories: \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("💥 No snapshot returned")
                    return
                }
                
                promise(.success(snapshot.documents.map { Category(dictinary: $0.data()) }))
            }
        }
        .eraseToAnyPublisher()
    }
}
