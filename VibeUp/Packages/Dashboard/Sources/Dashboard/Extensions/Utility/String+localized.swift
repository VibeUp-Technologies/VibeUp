import Foundation

extension String {
    
    var localized: String {
        String(localized: String.LocalizationValue(self), bundle: .module, locale: .current)
    }
}
