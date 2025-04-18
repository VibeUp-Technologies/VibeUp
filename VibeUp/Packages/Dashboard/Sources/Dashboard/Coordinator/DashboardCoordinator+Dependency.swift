import Combine
import DashboardTypes

public extension DashboardCoordinator {
    
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
        
        let requestService: DashboardRequestServicing
        
        public init(requestService: DashboardRequestServicing) {
            self.requestService = requestService
        }
    }
}
