import Combine

public protocol DashboardRequestServicing {
    
    func fetchCategories() -> AnyPublisher<[DashboardCategory], Error>
    func fetchUpcomingEvents() -> AnyPublisher<[DashboardUpcomingEvent], Error>
}
