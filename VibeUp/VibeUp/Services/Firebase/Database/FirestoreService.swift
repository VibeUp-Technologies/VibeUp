import Foundation
import Combine
import FirebaseFirestore

protocol FirestoreServicing {
    
    func create(with request: FirestoreRequest) -> AnyPublisher<Void, Error>
    func read<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error>
    func update(with request: FirestoreRequest) -> AnyPublisher<Void, Error>
}

final class FirestoreService {
    
    private lazy var firestore = Firestore.firestore()
}

// MARK: - FirestoreServicing

extension FirestoreService: FirestoreServicing {
    
    func create(with request: FirestoreRequest) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            firestore.collection(request.collection).addDocument(data: request.body) { error in
                if let error = error {
                    print("💥 Fetching rrror: \(error)")
                    return
                }
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
 
    func read<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error> {
        Future { [unowned self] promise in
            let collection = firestore.collection(request.collection)
            
            var query: Query = collection
            if let filter = request.filter {
                query = collection.whereFilter(filter)
            }
            
            query.getDocuments() { snapshot, error in
                if let error = error {
                    print("💥 Fetching rrror: \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("💥 No snapshot returned")
                    return
                }
                
                print("--> Request", request)
                print("--> Data", snapshot.documents.compactMap { $0.data() })
                
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
