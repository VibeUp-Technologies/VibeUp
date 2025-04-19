import Foundation
import Combine
import DashboardTypes

final class HomeViewModel: ObservableObject {
    
    enum Event {
        case category(DashboardCategory)
    }
    
    @Published private(set) var totalNumberOfEvents: Int = 0
    @Published private(set) var categoryViewModels: [CategoryCellViewModel] = []
    @Published private(set) var upcomingEventViewModels: [UpcomingEventCellViewModel] = []
    @Published private(set) var popularEventViewModels: [PopularEventCellViewModel] = []
    
    private let dependency: Dependency
    private let onEvent: (Event) -> Void
    
    private var categoriesCancelabel: AnyCancellable?
    private var upcomingEventsCancelabel: AnyCancellable?
    
    init(
        dependency: Dependency,
        onEvent: @escaping (Event) -> Void
    ) {
        self.dependency = dependency
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
        categoriesCancelabel = dependency.services.requestService.fetchCategories()
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
        upcomingEventsCancelabel = dependency.services.requestService.fetchUpcomingEvents()
            .sink(
                receiveCompletion: { _ in
                    
                },
                receiveValue: { [unowned self] events in
                    upcomingEventViewModels = events.enumerated().map { index, event in
                        UpcomingEventCellViewModel(
                            dependency: .init(
                                input: .init(
                                    isAuthenticated: dependency.input.isAuthenticated,
                                    event: event
                                ),
                                services: .init(
                                    requestService: dependency.services.requestService
                                )
                            )
                        )
                    }
                    
                    popularEventViewModels = events.enumerated().map { index, event in
                        PopularEventCellViewModel(
                            dependency: .init(
                                input: .init(
                                    isAuthenticated: dependency.input.isAuthenticated,
                                    event: event,
                                    showDivider: index != events.endIndex - 1
                                ),
                                services: .init(
                                    requestService: dependency.services.requestService
                                )
                            )
                        )
                    }
                    
                    totalNumberOfEvents = events.count
                }
            )
    }
}
