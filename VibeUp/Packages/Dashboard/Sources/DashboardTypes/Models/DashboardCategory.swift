import Foundation

public struct DashboardCategory {
    
    public let name: String
    public let imageId: Int
    
    public init(
        name: String,
        imageId: Int
    ) {
        self.name = name
        self.imageId = imageId
    }
}
