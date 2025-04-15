import Foundation

public enum Validated<E>: Equatable where E: Equatable {
    case success
    case failure(E)
}

public extension Validated {
    
    var isValid: Bool {
        self == .success
    }
    
    func `do`(onSuccess: () -> Void, onFailure: (E) -> Void) {
        if case let .failure(error) = self {
            onFailure(error)
            return
        }
        
        onSuccess()
    }
}

public protocol Validating {
    func validate(_ input: String, rules: [ValidationRule]) -> Validated<ValidationError>
}

public final class Validator: Validating {

    public init() {}

    public func validate(_ input: String, rules: [ValidationRule]) -> Validated<ValidationError> {
        rules.map { $0.check(input) }.first { !$0.isValid } ?? .success
    }
}
