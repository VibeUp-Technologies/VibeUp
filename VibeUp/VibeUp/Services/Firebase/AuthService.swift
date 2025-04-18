import Combine
import FirebaseAuth

protocol AuthServicing {
    
    var user: AnyPublisher<User?, Never> { get }
    var isAuthenticated: AnyPublisher<Bool, Never> { get }
    
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error>
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error>
    func logOut() -> AnyPublisher<Void, Error>
}

final class AuthService {
    
    lazy var user: AnyPublisher<User?, Never> = _user
        .eraseToAnyPublisher()
    
    lazy var isAuthenticated: AnyPublisher<Bool, Never> = _user
        .map { $0 != nil }
        .eraseToAnyPublisher()
    
    private lazy var _user: CurrentValueSubject<User?, Never> = .init(
        auth.currentUser
    )
    
    private lazy var auth = Auth.auth()
}

// MARK: - AuthServicing

extension AuthService: AuthServicing {
    
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
                
                print("-->", result.user)
                
                _user.send(result.user)
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // TODO: - Create favorite collection
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
                
                print("-->", result.user)
                
                _user.send(result.user)
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            do {
                try auth.signOut()
                _user.send(nil)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
