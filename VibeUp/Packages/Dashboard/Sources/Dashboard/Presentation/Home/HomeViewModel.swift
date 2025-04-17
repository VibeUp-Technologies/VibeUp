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
    
    @Published private(set) var categoryViewModels: [CategoryCellViewModel] = []
    @Published private(set) var upcomingEventViewModels: [UpcomingEventCellViewModel] = []
    
    private let requestService: DashboardRequestServicing
    private let onEvent: (Event) -> Void
    
    private var categoriesCancelabel: AnyCancellable?
    private var upcomingEventsCancelabel: AnyCancellable?
    
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
        fetchUpcomingEvents()
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
                    categoryViewModels = $0.map(CategoryCellViewModel.init)
                }
            )
    }
    
    func fetchUpcomingEvents() {
        upcomingEventsCancelabel = requestService.fetchUpcomingEvents()
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] in
                    upcomingEventViewModels = $0.map(UpcomingEventCellViewModel.init)
                }
            )
    }
}
