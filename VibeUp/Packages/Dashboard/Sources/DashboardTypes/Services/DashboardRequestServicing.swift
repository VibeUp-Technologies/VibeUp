import Combine

public protocol DashboardRequestServicing {
    
    func fetchCategories() -> AnyPublisher<[DashboardCategory], Error>
}
