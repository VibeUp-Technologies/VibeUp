import Combine

protocol AuthStating {
    
    var user: AnyPublisher<VPUser?, Never> { get }
    var isAuthenticated: AnyPublisher<Bool, Never> { get }
    
    func update(_ user: VPUser)
    func clear()
}

final class AuthState {
    
    lazy var user: AnyPublisher<VPUser?, Never> = _user
        .eraseToAnyPublisher()
    
    lazy var isAuthenticated: AnyPublisher<Bool, Never> = _user
        .map { $0 != nil }
        .eraseToAnyPublisher()
    
    private lazy var _user: CurrentValueSubject<VPUser?, Never> = .init(nil)
}

// MARK: - AuthStating

extension AuthState: AuthStating {
    
    func update(_ user: VPUser) {
        _user.send(user)
    }
    
    func clear() {
        _user.send(nil)
    }
}
