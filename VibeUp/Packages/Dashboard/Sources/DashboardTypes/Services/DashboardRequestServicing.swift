import Combine

public protocol DashboardRequestServicing {
    
    func fetchCategories() -> AnyPublisher<[Category], Error>
}
