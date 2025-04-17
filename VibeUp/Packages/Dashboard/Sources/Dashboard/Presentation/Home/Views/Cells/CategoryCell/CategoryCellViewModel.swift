import Foundation
import DashboardTypes

struct CategoryCellViewModel: Identifiable {
    
    let id: String
    let title: String
    let image: String
    
    init(category: DashboardCategory) {
        id = category.id
        title = category.name
        image = category.symbolName
    }
}
