import Foundation

final class HomeViewModel: ObservableObject {
    
    enum Event {
        case test
    }
    
    private let onEvent: (Event) -> Void
    
    init(onEvent: @escaping (Event) -> Void) {
        self.onEvent = onEvent
    }
    
    func onTest() {
        onEvent(.test)
    }
}
