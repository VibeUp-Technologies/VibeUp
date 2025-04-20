import Combine
import FavoriteTypes

extension FavoriteEventCellViewModel {
    
    struct Dependency {
        
        let input: Input
        let services: Services
    }
    
    struct Input {
        
        let event: FavoriteEvent
        let showDivider: Bool
    }
    
    struct Services {
        
        let requestService: FavoritesRequestServicing
    }
}
