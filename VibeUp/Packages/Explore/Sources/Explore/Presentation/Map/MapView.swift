import SwiftUI
import MapKit
import DesignSystem
import ExploreTypes // TODO: - Remove

struct MapView: View {
    
    @ObservedObject
    private var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let locations):
                makeMapView(locations)
            }
        }
        .onFirstAppear(viewModel.onFirstAppear)
    }
}

// MARK: - Private

private extension MapView {
    
    func makeMapView(_ locations: [MapLocation]) -> some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: locations) { location in
            MapAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: location.latitude,
                    longitude: location.longitude
                ),
                content: {
                    Image(systemName: "pin.circle.fill").foregroundColor(.red)
                    Text(location.name)
                }
            )
        }
        .overlay(alignment: .bottom, content: { eventListView })
    }
    
    var eventListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: Spacing.padding_2) {
                ForEach(0..<5) { _ in
                    Color.red.frame(width: 280.0)
                }
            }
            .padding(.horizontal, Spacing.padding_2)
        }
        .frame(height: 220.0)
        .padding(.bottom, Spacing.padding_6)
    }
}
