import Foundation
import Combine
import FirebaseFirestore
import Logger

protocol FirestoreServicing {
    
    func create(with request: FirestoreRequest) -> AnyPublisher<Void, Error>
    func read<Data: FirestoreData>(with request: FirestoreRequest) -> AnyPublisher<[Data], Error>
    func update(with request: FirestoreRequest) -> AnyPublisher<Void, Error>
}

final class FirestoreService {
    
    private lazy var firestore = Firestore.firestore()
    
    private let logger: Logging?
    
    init(logger: Logging?) {
        self.logger = logger
    }
}

// MARK: - FirestoreServicing

extension FirestoreService: FirestoreServicing {
    
    func create(with request: FirestoreRequest) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            let collection = firestore.collection(request.collection)
            collection.addDocument(data: request.body) { [self] error in
                if let error = error {
                    log(error: "Create error: \(error)")
                    promise(.failure(error))
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
            
            query.getDocuments() { [self] snapshot, error in
                if let error = error {
                    log(error: "Read error: \(error)")
                    promise(.failure(error))
                    return
                }
                
                guard let snapshot = snapshot else {
                    log(error: "No snapshot returned")
                    promise(.failure(NSError(domain: "No snapshot returned", code: .zero)))
                    return
                }
                
                log(request: request, snapshot: snapshot)
                
                let result: [Data] = snapshot
                    .documents
                    .compactMap { .init(id: $0.documentID, data: $0.data()) }
                
                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(with request: FirestoreRequest) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            let collection = firestore.collection(request.collection).document(request.document)
            collection.updateData(request.body) { [self] error in
                if let error = error {
                    log(error: "Update error: \(error)")
                    promise(.failure(error))
                    return
                }
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Logging

private extension FirestoreService {
    
    func log(request: FirestoreRequest, snapshot: QuerySnapshot) {
        var message = "\n"
        message += "🗂️ Collection: \(request.collection)"
        message += "\n"
        message += "📃 Document: \(request.document.isEmpty ? "Empty" : request.document)"
        message += "\n"
        
        let data = snapshot.documents.map {
            var dictionary: [String: Any] = [:]
            dictionary["documentID"] = $0.documentID
            dictionary.merge($0.data())
            return dictionary
        }
        message += "📥 Response: \(data)"
        
        log(message: message)
    }
    
    func log(error: String) {
        log(message: "❌ Error: \(error)")
    }
    
    func log(message: String) {
        logger?.log(category: "FirestoreService", level: .debug, message: "\(message)")
    }
}
