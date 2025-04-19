import Foundation
import FlowStacks

public final class FavoritesCoordinator: ObservableObject {
    
    @Published var routes: [Route<Screen>] = []
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
        
        setupRoot()
    }
}

private extension FavoritesCoordinator {
    
    func setupRoot() {
        routes = [.root(.favorites(makeFavoriteViewModel()))]
    }
    
    func makeFavoriteViewModel() -> FavoritesViewModel {
        FavoritesViewModel(
            dependency: .init(
                services: .init(
                    requestSetvice: dependency.services.requestSetvice
                )
            )
        )
    }
}
