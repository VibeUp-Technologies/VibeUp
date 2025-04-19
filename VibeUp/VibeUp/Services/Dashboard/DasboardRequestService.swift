import Combine
import DashboardTypes

final class DasboardRequestService {
    
    private let authService: AuthServicing
    private let firestoreService: FirestoreServicing
    
    init(
        authService: AuthServicing,
        firestoreService: FirestoreServicing
    ) {
        self.authService = authService
        self.firestoreService = firestoreService
    }
}

// MARK: - DashboardRequestServicing

extension DasboardRequestService: DashboardRequestServicing {
    
    func fetchCategories() -> AnyPublisher<[DashboardCategory], Error> {
        firestoreService.read(with: GETCategoriesRequest())
    }
    
    func fetchUpcomingEvents() -> AnyPublisher<[DashboardUpcomingEvent], Error> {
        firestoreService.read(with: GETUpcomingEventsRequest())
            .flatMap { [unowned self] (events: [DashboardUpcomingEvent]) in
                authService.user
                    .compactMap { $0 }
                    .map { user in
                        events.map { event in
                            if user.favoriteEvents.contains(where: { $0 == event.id }) {
                                event.makeFavorte()
                            } else {
                                event
                            }
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func addToFavorites(_ eventID: String) -> AnyPublisher<Void, Error> {
        authService.user
            .compactMap { $0 }
            .flatMap { [unowned self] in
                firestoreService.update(
                    with: PUTFavoriteEventRequest(
                        userID: $0.id,
                        eventID: eventID
                    )
                )
            }
            .eraseToAnyPublisher()
    }
    
    func removeFromFavorites(_ eventID: String) -> AnyPublisher<Void, Error> {
        authService.user
            .compactMap { $0 }
            .flatMap { [unowned self] in
                firestoreService.update(
                    with: DELETEFavoriteEventRequest(
                        userID: $0.id,
                        eventID: eventID
                    )
                )
            }
            .eraseToAnyPublisher()
    }
}
