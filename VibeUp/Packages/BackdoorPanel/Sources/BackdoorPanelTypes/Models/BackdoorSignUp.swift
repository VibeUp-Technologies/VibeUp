import Foundation

public struct BackdoorSignUp {
    
    public let email: String
    public let password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}
