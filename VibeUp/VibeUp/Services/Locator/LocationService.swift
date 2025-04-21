import Foundation
import CoreLocation
import Logger

protocol LocationServicing {
    
    func setup()
}

final class LocationService: NSObject {
    
    private let manager = CLLocationManager()
    
    private let logger: Logging?
    private let locationState: LocationStating
    
    init(
        logger: Logging?,
        locationState: LocationStating
    ) {
        self.logger = logger
        self.locationState = locationState
    }
}

// MARK: - LocationServicing

extension LocationService: LocationServicing {
    
    func setup() {
        manager.delegate = self
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.startUpdatingLocation()
            log(message: "AuthorizedAlways")
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            log(message: "AuthorizedWhenInUse")
        case .restricted:
            log(message: "Restricted")
        case .denied:
            log(message: "Denied")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            log(message: "NotDetermined")
        @unknown default:
            log(error: "authorizationStatus unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        locationState.update(currentLocation)
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        log(message: "Current location (latitude: \(latitude), longitude: \(longitude))")
    }
}

// MARK: - Logging

private extension LocationService {
    
    func log(error: String) {
        log(message: "❌ Error: \(error)")
    }
    
    func log(message: String) {
        logger?.log(
            category: "LocationService",
            level: .debug,
            message: "📍 \(message)"
        )
    }
}
