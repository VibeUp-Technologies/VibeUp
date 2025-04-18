import Combine
import DashboardTypes

extension PopularEventCellViewModel {
    
    struct Dependency {
        
        let input: Input
        let services: Services
    }
    
    struct Input {
        
        let isAuthenticated: AnyPublisher<Bool, Never>
        let event: DashboardUpcomingEvent
        let showDivider: Bool
    }
    
    struct Services {
        
        let requestService: DashboardRequestServicing
    }
}
