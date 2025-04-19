import Foundation

struct VPUser {
    
    let id: String
    private(set) var favoriteEvents: [String]
    
    init(id: String) {
        self.id = id
        self.favoriteEvents = []
    }
    
    init(
        id: String,
        favoriteEvents: [String]
    ) {
        self.id = id
        self.favoriteEvents = favoriteEvents
    }
}

extension VPUser {
    
    func appendFavoriteEvent(_ id: String) -> Self {
        var copy = self
        copy.favoriteEvents.append(id)
        return copy
    }
    
    func removeFavoriteEvent(_ id: String) -> Self {
        var copy = self
        copy.favoriteEvents.removeAll(where: { $0 == id })
        return copy
    }
}
