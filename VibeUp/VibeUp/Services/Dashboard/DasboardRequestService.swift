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
        firestoreService.get(with: GETCategoriesRequest())
    }
    
    func fetchUpcomingEvents() -> AnyPublisher<[DashboardUpcomingEvent], Error> {
        fetchFavorite()
            .compactMap { $0 }
            .flatMap { [unowned self] favorite in
                firestoreService.get(with: GETUpcomingEventsRequest())
                    .map { (events: [DashboardUpcomingEvent]) in
                        events.map { event in
                            if favorite.events.contains(where: { $0 == event.id }) {
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
    
    func addToFavorites(_ eventId: String) -> AnyPublisher<Void, any Error> {
        authService.user
            .compactMap { $0 }
            .flatMap { [unowned self] in
                firestoreService.update(
                    with: PUTFavoriteEventRequest(
                        userId: $0.uid,
                        eventId: eventId
                    )
                )
            }
            .eraseToAnyPublisher()
    }
    
    func removeFromFavorites(_ eventId: String) -> AnyPublisher<Void, Error> {
        authService.user
            .compactMap { $0 }
            .flatMap { [unowned self] in
                firestoreService.update(
                    with: DELETEFavoriteEventRequest(
                        userId: $0.uid,
                        eventId: eventId
                    )
                )
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private

private extension DasboardRequestService {
    
    func fetchFavorite() -> AnyPublisher<Favorite?, Error> {
        authService.user
            .compactMap { $0 }
            .flatMap { [unowned self] user in
                firestoreService.get(with: GETFavoriteEventsRequest())
                    .map { (favorites: [Favorite]) in
                        favorites.first(where: { $0.id == user.uid })
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
