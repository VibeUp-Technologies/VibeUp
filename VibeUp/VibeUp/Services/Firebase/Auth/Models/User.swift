import Foundation

struct VPUser {
    
    let id: String
    let favoriteEvents: [String]
    
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
