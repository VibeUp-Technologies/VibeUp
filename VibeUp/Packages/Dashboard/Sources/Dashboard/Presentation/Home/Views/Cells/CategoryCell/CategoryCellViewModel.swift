import Foundation
import DashboardTypes

struct CategoryCellViewModel: Identifiable {
    
    enum Event {
        case details
    }
    
    let id: String
    let title: String
    let image: String
    
    private let onEvent: (Event) -> Void
    
    init(
        category: DashboardCategory,
        onEvent: @escaping (Event) -> Void
    ) {
        id = category.id
        title = category.name
        image = category.symbolName
        
        self.onEvent = onEvent
    }
}

extension CategoryCellViewModel {
    
    func onTap() {
        onEvent(.details)
    }
}
