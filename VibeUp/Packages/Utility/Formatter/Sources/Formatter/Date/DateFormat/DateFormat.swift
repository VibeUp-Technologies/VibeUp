import Foundation

public enum DateFormat: Hashable {

    /// dd.MM
    case dayMonth
    /// yyyy.MM.dd
    case shortYearFirst
    /// dd.MM.yyyy
    case shortDayFirst
    /// d MMMM
    case month
    /// d MMM yyyy
    case shortMonth
    /// d MMMM yyyy
    case year
    /// dd MMMM yyyy, HH:mm
    case yearAndTime
    /// dd.MM.yyyy HH:mm:ss
    case yearAndTimeWithSeconds
    /// yyyy-MM-dd
    case yearMonthDay
    /// MMM yyyy
    case monthAndYear
    // HH:mm
    case hoursAndMinutes

    case custom(String)

    var description: String {
        switch self {
        case .dayMonth:
            return "dd.MM"
        case .shortYearFirst:
            return "yyyy.MM.dd"
        case .shortDayFirst:
            return "dd.MM.yyyy"
        case .month:
            return "d MMMM"
        case .shortMonth:
            return "d MMM yyyy"
        case .year:
            return "d MMMM yyyy"
        case .yearAndTime:
            return "dd MMMM yyyy, HH:mm"
        case .yearAndTimeWithSeconds:
            return "dd.MM.yyyy HH:mm:ss"
        case .yearMonthDay:
            return "yyyy-MM-dd"
        case .monthAndYear:
            return "MMM yyyy"
        case .hoursAndMinutes:
            return "HH:mm"
        case .custom(let format):
            return format
        }
    }
}
