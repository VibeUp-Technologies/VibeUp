import Foundation
import Combine
import FavoriteTypes

public extension FavoritesCoordinator {
    
    struct Dependency {
        
        let input: Input
        let services: Services
        
        public init(
            input: Input,
            services: Services
        ) {
            self.input = input
            self.services = services
        }
    }
    
    struct Input {
        
        let isAuthenticated: AnyPublisher<Bool, Never>
        
        public init(isAuthenticated: AnyPublisher<Bool, Never>) {
            self.isAuthenticated = isAuthenticated
        }
    }
    
    struct Services {
        
        let requestSetvice: FavoritesRequestServicing
        
        public init(requestSetvice: FavoritesRequestServicing) {
            self.requestSetvice = requestSetvice
        }
    }
}
