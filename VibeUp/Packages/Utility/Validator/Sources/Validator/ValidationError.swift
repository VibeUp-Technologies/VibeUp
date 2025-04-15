import Foundation

public enum ValidationError: Equatable {
    case numbers
    case stringEmpty
    case invalidEmail
    case notAlphanumeric
    case thereAreNoOneCharacters
    case thereAreNoOneNumbers
    case thereAreNoOneUppercaseCharacters
    case thereAreNoOneLowercaseCharacters
    case exceedsMinLength(Int)
    case exceedsMaxLength(Int)
    case containsNonLatinCharacters
    case invalidUsername
}
