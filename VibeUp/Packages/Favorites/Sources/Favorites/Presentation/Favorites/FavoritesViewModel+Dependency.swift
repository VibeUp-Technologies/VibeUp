import Foundation
import FavoriteTypes

extension FavoritesViewModel {
    
    struct Dependency {
        
        let services: Services
    }
    
    struct Services {
        
        let requestSetvice: FavoritesRequestServicing
    }
}
