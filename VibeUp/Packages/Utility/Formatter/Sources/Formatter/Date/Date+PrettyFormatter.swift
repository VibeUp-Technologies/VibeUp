import Foundation

public extension Date {

    func prettyFormatted(with formatStyle: DateFormatStyle) -> String {
        DateFormatterCache.formatter(with: formatStyle).string(from: self)
    }
}

public extension Date {

    func prettyFormatted(
        _ format: DateFormat,
        locale: Locale = .enUS,
        timeZone: TimeZone = .current
    ) -> String {
        let style = DateFormatStyle.format(format, locale: locale, timeZone: timeZone)
        return prettyFormatted(with: style)
    }

    func prettyFormattedFromTemplate(
        _ template: DateFormat,
        locale: Locale = .enUS,
        timeZone: TimeZone = .current
    ) -> String {
        let style = DateFormatStyle.template(template, locale: locale, timeZone: timeZone)
        return prettyFormatted(with: style)
    }
}
