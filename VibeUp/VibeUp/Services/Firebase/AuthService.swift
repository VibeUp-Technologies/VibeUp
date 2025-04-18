import Combine
import FirebaseAuth

protocol AuthServicing {
    
    var isAuthenticated: AnyPublisher<Bool, Never> { get }
    
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error>
    func logOut() -> AnyPublisher<Void, Error>
}

final class AuthService {
    
    lazy var isAuthenticated: AnyPublisher<Bool, Never> = _isAuthenticated.eraseToAnyPublisher()
    
    private lazy var _isAuthenticated: CurrentValueSubject<Bool, Never> = .init(
        auth.currentUser != nil
    )
    
    private lazy var auth = Auth.auth()
}

// MARK: - AuthServicing

extension AuthService: AuthServicing {
    
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
                
                _isAuthenticated.send(true)
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        Future { [unowned self] promise in
            do {
                try auth.signOut()
                _isAuthenticated.send(false)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
