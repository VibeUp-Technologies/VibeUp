import Foundation
import Combine
import DashboardTypes

extension HomeViewModel {
    
    struct Dependency {
        
        let services: Services
    }
    
    struct Services {
        
        let requestService: DashboardRequestServicing
    }
}

final class HomeViewModel: ObservableObject {
    
    enum Event {
        case test
    }
    
    @Published private(set) var categories: [DashboardCategory] = []
    
    private let requestService: DashboardRequestServicing
    private let onEvent: (Event) -> Void
    
    private var categoriesCancelabel: AnyCancellable?
    
    init(
        dependency: Dependency,
        onEvent: @escaping (Event) -> Void
    ) {
        self.requestService = dependency.services.requestService
        self.onEvent = onEvent
    }
}

// MARK: - Actions

extension HomeViewModel {
    
    func onFirstAppear() {
        fetchCategeries()
    }
    
    func onTest() {
        onEvent(.test)
    }
}

// MARK: - Private

private extension HomeViewModel {
    
    func fetchCategeries() {
        categoriesCancelabel = requestService.fetchCategories()
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] in
                    categories = $0
                }
            )
    }
}
