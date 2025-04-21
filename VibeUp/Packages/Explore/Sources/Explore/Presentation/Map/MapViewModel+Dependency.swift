import Foundation
import Combine
import CoreLocation

extension MapViewModel {
    
    struct Dependency {
        
        let input: Input
    }
    
    struct Input {
        
        let currentLocation: AnyPublisher<CLLocation?, Never>
    }
}
