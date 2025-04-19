import Combine
import DashboardTypes

extension UpcomingEventCellViewModel {
    
    struct Dependency {
        
        let input: Input
        let services: Services
    }
    
    struct Input {
        
        let isAuthenticated: AnyPublisher<Bool, Never>
        let event: DashboardUpcomingEvent
    }
    
    struct Services {
        
        let requestService: DashboardRequestServicing
    }
}
