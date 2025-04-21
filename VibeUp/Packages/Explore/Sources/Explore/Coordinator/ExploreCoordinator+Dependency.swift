import Foundation
import Combine
import ExploreTypes
import CoreLocation

public extension ExploreCoordinator {
    
    struct Dependency {
        
        let input: Input
        
        public init(input: Input) {
            self.input = input
        }
    }
    
    struct Input {
        
        let currentLocation: AnyPublisher<CLLocation?, Never>
        
        public init(currentLocation: AnyPublisher<CLLocation?, Never>) {
            self.currentLocation = currentLocation
        }
    }
}
