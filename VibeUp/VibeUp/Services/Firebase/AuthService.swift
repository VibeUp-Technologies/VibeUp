import Combine
import FirebaseAuth

protocol AuthServicing {
    
    func singUp(email: String, password: String) -> AnyPublisher<Void, Error>
}

final class AuthService {
    
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
                
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
