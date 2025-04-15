import Foundation

enum ValidationRegex: String {
    case numbers = #"^\d+$"#
    case alphanumeric = #"^[A-Za-zА-Яа-яЇїІіЄєҐґ0-9]+$"#
    case email = #"^[A-Za-z0-9!#$%&'*+/=?_`{|}~^-]+(?:\.[A-Za-z0-9!#$%&'*+/=?_`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,10}$"#
    case latin = #"^[a-zA-Z]+$"#
    case nospecialCharacters = #"^[a-zA-z0-9.-]+$"#
}
