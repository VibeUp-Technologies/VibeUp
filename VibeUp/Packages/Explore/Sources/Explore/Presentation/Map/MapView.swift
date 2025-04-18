import SwiftUI
import MapKit
import DesignSystem

struct MapView: View {
    
    struct Place: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Los Angeles!
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    let places = [
        Place(name: "Griffith Observatory", coordinate: CLLocationCoordinate2D(latitude: 34.1184, longitude: -118.3004)),
        Place(name: "Santa Monica Pier", coordinate: CLLocationCoordinate2D(latitude: 34.0094, longitude: -118.4973))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: places) { place in
            MapAnnotation(coordinate: place.coordinate) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text(place.name)
                        .font(.caption)
                        .padding(4)
                        .background(.ultraThinMaterial)
                        .cornerRadius(6)
                }
            }
        }
        .navigationBar(configuration: .init(isHidden: true))
    }
}
