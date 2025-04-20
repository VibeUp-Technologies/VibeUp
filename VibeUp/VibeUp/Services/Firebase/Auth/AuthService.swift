import Combine
import FirebaseAuth
import Logger

protocol AuthServicing {
    
    func setup()
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error>
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error>
    func logOut() -> AnyPublisher<Void, Error>
}

final class AuthService {
    
    private lazy var auth = Auth.auth()
    
    private let logger: Logging?
    private let authState: AuthStating
    private let firestoreService: FirestoreServicing
    
    private var stateChangeListener: NSObjectProtocol?
    private var fetchUserCancelable: AnyCancellable?
    
    init(
        logger: Logging?,
        authState: AuthStating,
        firestoreService: FirestoreServicing
    ) {
        self.logger = logger
        self.authState = authState
        self.firestoreService = firestoreService
    }
}

// MARK: - AuthServicing

extension AuthService: AuthServicing {
    
    func setup() {
        stateChangeListener = auth.addStateDidChangeListener { [unowned self] _, user in
            guard let user else { return }
            
            fetchUserCancelable = fetchUser(by: user.uid)
                .sink(
                    receiveCompletion: { [self] compition in
                        guard case .failure(let error) = compition else { return }
                        
                        log(error: "Fetch user error: \(error)")
                    },
                    receiveValue: { [self] in
                        authState.update($0)
                    }
                )
        }
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            auth.signIn(withEmail: email, password: password) { [self] result, error in
                if let error {
                    log(error: "SignIn error: \(error)")
                    promise(.failure(error))
                    return
                }
                
                guard let result else {
                    log(error: "No user result")
                    promise(.failure(NSError(domain: "No user result", code: .zero)))
                    return
                }
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            auth.createUser(withEmail: email, password: password) { [self] result, error in
                if let error {
                    log(error: "Create user error: \(error)")
                    promise(.failure(error))
                    return
                }
                
                guard let result else {
                    log(error: "No user result")
                    promise(.failure(NSError(domain: "No user result", code: .zero)))
                    return
                }
                
                let user = VPUser(id: result.user.uid)
                promise(.success(user))
            }
        }
        .flatMap { [unowned self] in
            createUser($0)
        }
        .eraseToAnyPublisher()
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            do {
                try auth.signOut()
                authState.clear()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Private

private extension AuthService {
    
    func createUser(_ user: VPUser) -> AnyPublisher<Void, Error> {
        firestoreService.create(with: POSTUserRequest(body: user))
            .handleEvents(
                receiveOutput: { [unowned self] in
                    authState.update(user)
                }
            )
            .eraseToAnyPublisher()
    }
    
    func fetchUser(by id: String) -> AnyPublisher<VPUser, Error> {
        firestoreService.read(with: GETUserRequest(userID: id))
            .compactMap { $0.first }
            .eraseToAnyPublisher()
    }
}

// MARK: - Logging

private extension AuthService {
    
    func log(error: String) {
        log(message: "❌ Error: \(error)")
    }
    
    func log(message: String) {
        logger?.log(
            category: "AuthService",
            level: .debug,
            message: "🚹 Auth: \(message)"
        )
    }
}
