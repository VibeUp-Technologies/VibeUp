import Foundation
import FavoriteTypes

public extension FavoritesCoordinator {
    
    struct Dependency {
        
        let services: Services
        
        public init(services: Services) {
            self.services = services
        }
    }
    
    struct Services {
        
        let requestSetvice: FavoritesRequestServicing
        
        public init(requestSetvice: FavoritesRequestServicing) {
            self.requestSetvice = requestSetvice
        }
    }
}
