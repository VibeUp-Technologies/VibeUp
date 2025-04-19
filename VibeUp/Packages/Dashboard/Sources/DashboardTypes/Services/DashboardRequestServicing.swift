import Combine

public protocol DashboardRequestServicing {
    
    func fetchCategories() -> AnyPublisher<[DashboardCategory], Error>
    func fetchUpcomingEvents() -> AnyPublisher<[DashboardUpcomingEvent], Error>
    
    func addToFavorites(_ eventID: String) -> AnyPublisher<Void, Error>
    func removeFromFavorites(_ eventID: String) -> AnyPublisher<Void, Error>
}
