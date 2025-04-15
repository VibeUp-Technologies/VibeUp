public struct LogMessage: ExpressibleByStringLiteral,
                          ExpressibleByStringInterpolation {

    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = String

    public let message: String

    public init(stringLiteral value: String) {
        self.message = value
    }

    public init(stringInterpolation: String) {
        self.message = .init(stringLiteral: stringInterpolation)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.message = value
    }

    public init(unicodeScalarLiteral value: String) {
        self.message = value
    }
}
