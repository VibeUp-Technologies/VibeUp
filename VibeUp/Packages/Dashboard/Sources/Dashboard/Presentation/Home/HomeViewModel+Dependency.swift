import Combine
import DashboardTypes

extension HomeViewModel {
    
    struct Dependency {
        
        let input: Input
        let services: Services
    }
    
    struct Input {
        
        let isAuthenticated: AnyPublisher<Bool, Never>
    }
    
    struct Services {
        
        let requestService: DashboardRequestServicing
    }
}
