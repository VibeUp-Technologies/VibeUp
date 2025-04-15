import Foundation

@MainActor
public extension String {

    func prettyFormatted(
        incomingFormatStyle: DateFormatStyle,
        outgoingFormatStyle: DateFormatStyle
    ) -> String {
        let formatter = DateFormatterCache.formatter(with: incomingFormatStyle)

        if let date = formatter.date(from: self) {
            return date.prettyFormatted(with: outgoingFormatStyle)
        }
        return ""
    }
}
