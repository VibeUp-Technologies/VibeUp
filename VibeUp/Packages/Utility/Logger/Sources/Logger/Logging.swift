/// A protocol for logging messages.
public protocol Logging {

    /// Logs a message with the specified category, level, and message.
    ///
    /// - Parameters:
    ///   - category: The category of the log message.
    ///   - level: The log level of the message.
    ///   - message: The log message.
    func log(
        category: String,
        level: LogLevel,
        message: LogMessage
    )
}
