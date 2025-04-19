import Combine

public protocol FavoritesRequestServicing {
    
    func fetchFavoriteEvents() -> AnyPublisher<[FavoriteEvent], Error>
    func removeFromFavorites(_ eventID: String) -> AnyPublisher<Void, Error>
}
