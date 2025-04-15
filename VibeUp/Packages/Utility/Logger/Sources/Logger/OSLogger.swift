import OSLog

/// OSLogger is a class that provides logging functionality using the OSLog framework.
public final class OSLogger: Logging {

    private let subsystem: String

    /// Initializes an instance of OSLogger with the specified subsystem.
    ///
    /// - Parameter subsystem: The subsystem to be used for logging.
    public init(subsystem: String) {
        self.subsystem = subsystem
    }

    /// Logs a message with the specified category, log level, and log message.
    ///
    /// - Parameters:
    ///   - category: The category of the log message.
    ///   - level: The log level of the log message.
    ///   - message: The log message to be logged.
    public func log(category: String, level: LogLevel, message: LogMessage) {
        let logger = Logger(subsystem: subsystem, category: category)
        let message = String(format: "%@ %@", level.rawValue, message.message)
        logger.log(level: level.osLogType, "\(message, privacy: .public)")
    }
}

private extension LogLevel {

    /// Returns the corresponding OSLogType for the log level.
    var osLogType: OSLogType {
        switch self {
        case .warning, .debug:
            return .default
        case .info:
            return .info
        case .error:
            return .error
        }
    }
}
