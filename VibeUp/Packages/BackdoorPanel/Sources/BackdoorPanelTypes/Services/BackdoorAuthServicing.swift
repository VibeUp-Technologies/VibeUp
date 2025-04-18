import Combine

public protocol BackdoorAuthServicing {
    
    func signUp(with body: BackdoorSignUp) -> AnyPublisher<Void, Error>
    func logOut() -> AnyPublisher<Void, Error>
}
