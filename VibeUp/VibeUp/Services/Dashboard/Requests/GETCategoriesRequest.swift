import DashboardTypes

struct GETCategoriesRequest: FirestoreRequest {
    
    let path = "categories"
}

extension DashboardCategory: FirestoreData {
    
    init(dictinary: [String: Any]) {
        self.init(
            name: dictinary["name"] as? String ?? "",
            imageId: dictinary["imageId"] as? Int ?? .zero
        )
    }
}
