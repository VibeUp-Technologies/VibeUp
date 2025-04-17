import Foundation

public struct DashboardCategory {
    
    public let id: String
    public let type: `Type`
    
    public init(
        id: String,
        type: Type
    ) {
        self.id = id
        self.type = type
    }
}

public extension DashboardCategory {
    
    enum `Type`: String {
        case food
        case music
        case comedy
        case festival
        case clothing
    }
}
