import Combine
import CoreLocation

protocol LocationStating {
    
    var currentLocation: AnyPublisher<CLLocation?, Never> { get }
    
    func update(_ currentLocation: CLLocation)
}

final class LocationState {
    
    lazy var currentLocation: AnyPublisher<CLLocation?, Never> = _currentLocation
        .eraseToAnyPublisher()
    
    private lazy var _currentLocation: CurrentValueSubject<CLLocation?, Never> = .init(nil)
}

// MARK: - LocationStating

extension LocationState: LocationStating {
    
    func update(_ currentLocation: CLLocation) {
        _currentLocation.send(currentLocation)
    }
}
