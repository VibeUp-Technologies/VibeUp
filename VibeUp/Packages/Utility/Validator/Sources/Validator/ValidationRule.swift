import Foundation

public struct ValidationRule {

    let check: (_ input: String) -> Validated<ValidationError>
}

public extension ValidationRule {

    nonisolated(unsafe)
    static let notEmpty = ValidationRule {
        $0.isEmpty ? .failure(.stringEmpty) : .success
    }
    
    nonisolated(unsafe)
    static let validEmail = ValidationRule {
        validate(input: $0, regex: .email) ? .success : .failure(.invalidEmail)
    }
    
    nonisolated(unsafe)
    static let noSpecialCharacters = ValidationRule {
        validate(input: $0, regex: .nospecialCharacters) ? .success : .failure(.invalidUsername)
    }

    nonisolated(unsafe)
    static let alphanumeric = ValidationRule {
        validate(input: $0, regex: .alphanumeric) ? .success : .failure(.notAlphanumeric)
    }

    nonisolated(unsafe)
    static let numbers = ValidationRule {
        validate(input: $0, regex: .numbers) ? .success : .failure(.numbers)
    }
    
    nonisolated(unsafe)
    static let oneCharacter = ValidationRule { string in
        string.first(where: { $0.isLetter }) != nil ? .success : .failure(.thereAreNoOneCharacters)
    }
    
    nonisolated(unsafe)
    static let oneNumber = ValidationRule { string in
        string.first(where: { $0.isNumber }) != nil ? .success : .failure(.thereAreNoOneNumbers)
    }
    
    nonisolated(unsafe)
    static let onlyLatin = ValidationRule {
        validate(input: $0, regex: .latin) ? .success : .failure(.containsNonLatinCharacters)
    }
    
    nonisolated(unsafe)
    static let oneUppercasedCharacter = ValidationRule { string in
        string.first(
            where: {
                $0.uppercased() == String($0)
            }
        ) != nil ? .success : .failure(.thereAreNoOneUppercaseCharacters)
    }
    
    nonisolated(unsafe)
    static let oneLowercasedCharacter = ValidationRule { string in
        string.first(
            where: {
                $0.lowercased() == String($0)
            }
        ) != nil ? .success : .failure(.thereAreNoOneLowercaseCharacters)
    }
    
    nonisolated(unsafe)
    static func minLength(_ length: Int) -> ValidationRule {
        ValidationRule {
            $0.count < length ? .failure(.exceedsMaxLength(length)) : .success
        }
    }
    
    nonisolated(unsafe)
    static func maxLength(_ length: Int) -> ValidationRule {
        ValidationRule {
            $0.count > length ? .failure(.exceedsMaxLength(length)) : .success
        }
    }
}

extension ValidationRule {

    private static func validate(input: String, regex: ValidationRegex) -> Bool {
        input.range(of: regex.rawValue, options: .regularExpression) != nil
    }
}
