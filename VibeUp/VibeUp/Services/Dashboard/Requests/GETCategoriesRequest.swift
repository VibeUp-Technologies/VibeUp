import DashboardTypes

struct GETCategoriesRequest: FirestoreRequest {
    
    let path = "categories"
}

extension DashboardCategory: FirestoreData {
    
    init?(id: String, data: [String: Any]) {
        guard let type = Type(rawValue: data["type"] as? String ?? "") else { return nil }
        
        self.init(id: id, type: type)
    }
}
