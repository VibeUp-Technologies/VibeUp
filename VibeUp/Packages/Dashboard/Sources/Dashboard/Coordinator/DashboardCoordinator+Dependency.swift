import DashboardTypes

public extension DashboardCoordinator {
    
    struct Dependency {
        
        let services: Services
        
        public init(services: Services) {
            self.services = services
        }
    }
    
    struct Services {
        
        let requestService: DashboardRequestServicing
        
        public init(requestService: DashboardRequestServicing) {
            self.requestService = requestService
        }
    }
}
