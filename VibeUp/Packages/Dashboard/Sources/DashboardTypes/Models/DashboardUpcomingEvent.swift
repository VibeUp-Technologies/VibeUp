import Foundation

public struct DashboardUpcomingEvent {
    
    public let id: String
    public let date: Date
    public let image: String
    public let location: String
    public let name: String
    public let price: Price
    public let currencySymbol: String
    public let isFavorite: Bool
    
    public init(
        id: String,
        date: Date,
        image: String,
        location: String,
        name: String,
        price: Price,
        currencySymbol: String,
        isFavorite: Bool
    ) {
        self.id = id
        self.date = date
        self.image = image
        self.location = location
        self.name = name
        self.price = price
        self.currencySymbol = currencySymbol
        self.isFavorite = isFavorite
    }
}

public extension DashboardUpcomingEvent {
    
    struct Price {
        
        public let from: Int
        public let to: Int
        
        public init(
            from: Int,
            to: Int
        ) {
            self.from = from
            self.to = to
        }
    }
}

public extension DashboardUpcomingEvent {
    
    func makeFavorte() -> Self {
        .init(
            id: id,
            date: date,
            image: image,
            location: location,
            name: name,
            price: price,
            currencySymbol: currencySymbol,
            isFavorite: true
        )
    }
}

