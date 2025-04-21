import Foundation
import Combine
import MapKit
import ExploreTypes

final class MapViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded([MapLocation])
    }
    
    @Published var region = MKCoordinateRegion(
        center: .init(),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published private(set) var state: State = .loading
    
    private let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

// MARK: - Actions

extension MapViewModel {
    
    func onFirstAppear() {
        setupSubscriptions()
        
        fetchLocations()
    }
}

// MARK: - Private

private extension MapViewModel {
    
    func setupSubscriptions() {
        dependency.input.currentLocation
            .compactMap { $0 }
            .map { [unowned self] location in
                MKCoordinateRegion(
                    center: location.coordinate,
                    span: region.span
                )
            }
            .assign(to: &$region)
    }
    
    func fetchLocations() {
        Just(())
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { [unowned self] _ in
                (0..<50).map { index in
                    let maxOffsetMeters: Double = 1000 // радиус разброса в метрах
                    
                    let latOffset = Double.random(in: -maxOffsetMeters...maxOffsetMeters) / 111_000
                    let lonOffset = Double.random(in: -maxOffsetMeters...maxOffsetMeters) / (111_000 * cos(region.center.latitude * .pi / 180))
                    
                    return MapLocation(
                        name: "Test \(index + 1)",
                        latitude: region.center.latitude + latOffset,
                        longitude: region.center.longitude + lonOffset
                    )
                }
            }
            .map { .loaded($0) }
            .assign(to: &$state)
    }
}
