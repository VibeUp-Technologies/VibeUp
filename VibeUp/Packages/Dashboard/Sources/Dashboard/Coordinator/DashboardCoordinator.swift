import Foundation

public final class DashboardCoordinator: ObservableObject {
    
    let viewModelFactory = ViewModelFactory()
    
    public init() { }
}

final class ViewModelFactory {
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }
}
