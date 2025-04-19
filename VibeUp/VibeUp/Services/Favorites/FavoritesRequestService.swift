import Combine
import FavoriteTypes

final class FavoritesRequestService {
    
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

// MARK: - FavoritesRequestServicing

extension FavoritesRequestService: FavoritesRequestServicing {
    
    func fetchFavoriteEvents() -> AnyPublisher<[FavoriteEvent], Error> {
        authState.user
            .compactMap { $0?.favoriteEvents }
            .flatMap { [unowned self] in
                firestoreService.read(with: GETFavoriteEvents(ids: $0))
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
