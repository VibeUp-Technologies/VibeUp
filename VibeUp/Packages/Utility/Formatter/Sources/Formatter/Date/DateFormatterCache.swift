import Foundation

public final class DateFormatterCache {

    nonisolated(unsafe)
    private static let instance = DateFormatterCache()

    private var cache = [DateFormatStyle: DateFormatter]()

    private init() {}

    public static func formatter(with formatStyle: DateFormatStyle) -> DateFormatter {
        guard let formatter = instance.cache[formatStyle] else {
            let formatter = DateFormatter.makeFormatter(with: formatStyle)
            instance.cache[formatStyle] = formatter
            return formatter
        }
        return formatter
    }

    public static func reset() {
        instance.cache = [:]
    }
}
