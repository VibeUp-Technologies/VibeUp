import Foundation
import BackdoorPanelTypes

public extension BackdoorCoordinator {
    
    struct Dependency {
        
        let services: Services
        
        public init(services: Services) {
            self.services = services
        }
    }
    
    struct Services {
        
        let authService: BackdoorAuthServicing
        
        public init(authService: BackdoorAuthServicing) {
            self.authService = authService
        }
    }
}
