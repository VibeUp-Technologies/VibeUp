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
        case category(DashboardCategory)
    }
    
    @Published private(set) var totalNumberOfEvents: Int = 0
    @Published private(set) var categoryViewModels: [CategoryCellViewModel] = []
    @Published private(set) var upcomingEventViewModels: [UpcomingEventCellViewModel] = []
    @Published private(set) var popularEventViewModels: [PopularEventCellViewModel] = []
    
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
}

// MARK: - Private

private extension HomeViewModel {
    
    func fetchCategeries() {
        categoriesCancelabel = requestService.fetchCategories()
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] categories in
                    categoryViewModels = categories.map { category in
                        CategoryCellViewModel(
                            category: category,
                            onEvent: { [weak self] event in
                                switch event {
                                case .details:
                                    self?.onEvent(.category(category))
                                }
                            }
                        )
                    }
                }
            )
    }
    
    func fetchUpcomingEvents() {
        upcomingEventsCancelabel = requestService.fetchUpcomingEvents()
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] events in
                    upcomingEventViewModels = events.map(UpcomingEventCellViewModel.init)
                    
                    popularEventViewModels = events.enumerated().map {
                        PopularEventCellViewModel(event: $1, showDivider: $0 != events.endIndex - 1)
                    }
                    
                    totalNumberOfEvents = events.count
                }
            )
    }
}
