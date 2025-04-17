import Combine
import DashboardTypes

final class DasboardRequestService {
    
    private let firestoreService: FirestoreServicing
    
    init(firestoreService: FirestoreServicing) {
        self.firestoreService = firestoreService
    }
}

// MARK: - DashboardRequestServicing

extension DasboardRequestService: DashboardRequestServicing {
    
    func fetchCategories() -> AnyPublisher<[DashboardCategory], Error> {
        firestoreService.fetch(with: GETCategoriesRequest())
    }
}
