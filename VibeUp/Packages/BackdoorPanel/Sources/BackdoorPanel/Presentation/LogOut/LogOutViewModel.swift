import Foundation
import Combine
import BackdoorPanelTypes

final class LogOutViewModel: ObservableObject {
    
    private let authService: BackdoorAuthServicing
    
    private var logOutCancelable: AnyCancellable?
    
    init(authService: BackdoorAuthServicing) {
        self.authService = authService
    }
}

extension LogOutViewModel {
    
    func onLogOut() {
        logOutCancelable = authService.logOut()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
    }
}
