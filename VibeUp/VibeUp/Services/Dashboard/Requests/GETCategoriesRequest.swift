import DashboardTypes

struct GETCategoriesRequest: FirestoreRequest {
    
    let collection = "categories"
}

extension DashboardCategory: FirestoreData {
    
    init?(id: String, data: [String: Any]) {
        self.init(
            id: id,
            name: data["name"] as? String ?? "",
            symbolName: data["symbolName"] as? String ?? ""
        )
    }
}
