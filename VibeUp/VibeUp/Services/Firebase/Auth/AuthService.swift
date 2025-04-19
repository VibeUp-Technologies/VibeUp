import Combine
import FirebaseAuth

protocol AuthServicing {
    
    func setup()
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error>
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error>
    func logOut() -> AnyPublisher<Void, Error>
}

final class AuthService {
    
    private lazy var auth = Auth.auth()
    
    private let authState: AuthStating
    private let firestoreService: FirestoreServicing
    
    private var stateChangeListener: NSObjectProtocol?
    private var fetchUserCancelable: AnyCancellable?
    
    init(
        authState: AuthStating,
        firestoreService: FirestoreServicing
    ) {
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
                    receiveCompletion: { _ in },
                    receiveValue: { _ in }
                )
        }
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            auth.signIn(withEmail: email, password: password) { result, error in
                if let error {
                    print("💥 Error: \(error)")
                    return
                }
                
                guard let result else {
                    print("💥 No snapshot returned")
                    return
                }
                
                promise(.success(result.user))
            }
        }
        .flatMap { [unowned self] (user: User) in
            fetchUser(by: user.uid)
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            auth.createUser(withEmail: email, password: password) { result, error in
                if let error {
                    print("💥 Error: \(error)")
                    return
                }
                
                guard let result else {
                    print("💥 No snapshot returned")
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
            .handleEvents(
                receiveOutput: { [unowned self] in
                    authState.update($0)
                }
            )
            .eraseToAnyPublisher()
    }
}
