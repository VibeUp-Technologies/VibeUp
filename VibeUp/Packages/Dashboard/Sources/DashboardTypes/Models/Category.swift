import Foundation

public struct Category {
    
    public let name: String
    public let imageId: Int
    
    public init(dictinary: [String: Any]) {
        name = dictinary["name"] as? String ?? ""
        imageId = dictinary["imageId"] as? Int ?? .zero
    }
}
