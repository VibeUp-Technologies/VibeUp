import Foundation

extension Formatter {

    static func makeFormatter(with formatStyle: DateFormatStyle) -> DateFormatter {
        let formatter = DateFormatter()

        switch formatStyle {
        case let .format(dateFormat, locale, timeZone):
            formatter.locale = locale
            formatter.timeZone = timeZone
            formatter.dateFormat = dateFormat.description
        case let .template(dateFormat, locale, timeZone):
            formatter.locale = locale
            formatter.timeZone = timeZone
            formatter.setLocalizedDateFormatFromTemplate(dateFormat.description)
        }
        return formatter
    }
}
