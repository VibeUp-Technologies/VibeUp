import Combine

public protocol BackdoorAuthServicing {
    
    func signIn(with body: BackdoorSignIn) -> AnyPublisher<Void, Error>
    func signUp(with body: BackdoorSignUp) -> AnyPublisher<Void, Error>
    func logOut() -> AnyPublisher<Void, Error>
}
