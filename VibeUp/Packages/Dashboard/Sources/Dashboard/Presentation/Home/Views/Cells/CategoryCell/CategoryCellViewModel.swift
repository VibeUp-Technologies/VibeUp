import Foundation
import DashboardTypes

struct CategoryCellViewModel: Identifiable {
    
    let id: String
    let title: String
    let image: String
    
    init(category: DashboardCategory) {
        id = category.id
        title = category.type.title
        image = category.type.image
    }
}

// MARK: - Private

private extension DashboardCategory.`Type` {
    
    var title: String {
        switch self {
        case .music:
            "Music"
        case .food:
            "Food"
        case .comedy:
            "Comedy"
        case .festival:
            "Festival"
        case .clothing:
            "Clothing"
        }
    }
    
    var image: String {
        switch self {
        case .music:
            "music.note"
        case .food:
            "fork.knife"
        case .comedy:
            "theatermasks"
        case .festival:
            "fireworks"
        case .clothing:
            "figure.dance"
        }
    }
}
