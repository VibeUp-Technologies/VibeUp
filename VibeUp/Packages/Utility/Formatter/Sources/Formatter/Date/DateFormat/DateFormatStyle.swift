import Foundation

public enum DateFormatStyle: Hashable {

    case format(
        DateFormat,
        locale: Locale = .enUS,
        timeZone: TimeZone = .current
    )

    case template(
        DateFormat,
        locale: Locale = .enUS,
        timeZone: TimeZone = .current
    )
}
