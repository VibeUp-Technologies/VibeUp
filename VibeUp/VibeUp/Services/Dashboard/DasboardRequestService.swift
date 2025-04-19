import Combine
import DashboardTypes

final class DasboardRequestService {
    
    private let authState: AuthStating
    private let firestoreService: FirestoreServicing
    
    init(
        authState: AuthStating,
        firestoreService: FirestoreServicing
    ) {
        self.authState = authState
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
                authState.user
                    .map { user in
                        events.map { event in
                            if let user, user.favoriteEvents.contains(where: { $0 == event.id }) {
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
        authState.user
            .compactMap { $0 }
            .first()
            .flatMap { [unowned self] user in
                firestoreService.update(
                    with: PUTFavoriteEventRequest(
                        userID: user.id,
                        eventID: eventID
                    )
                )
                .handleEvents(
                    receiveOutput: { [unowned self] _ in
                        authState.update(user.appendFavoriteEvent(eventID))
                    }
                )
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func removeFromFavorites(_ eventID: String) -> AnyPublisher<Void, Error> {
        authState.user
            .compactMap { $0 }
            .first()
            .flatMap { [unowned self] user in
                firestoreService.update(
                    with: DELETEFavoriteEventRequest(
                        userID: user.id,
                        eventID: eventID
                    )
                )
                .handleEvents(
                    receiveOutput: { [unowned self] _ in
                        authState.update(user.removeFavoriteEvent(eventID))
                    }
                )
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
