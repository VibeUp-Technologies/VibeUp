import SwiftUI
import Dashboard

struct TabBarView: View {
    
    enum Tab {
        case home(DashboardCoordinator)
        case explore
        case saved
        case profile
    }
    
    private let tabs: [Tab]
    
    init(tabs: [Tab]) {
        self.tabs = tabs
    }
    
    var body: some View {
        TabView {
            ForEach(tabs.indices, id: \.self) { index in
                switch tabs[index] {
                case .home(let coordinator):
                    DashboardView(coordinator: coordinator)
                        .tabItem { Label("Home", systemImage: "house") }
                case .explore:
                    Color.green.tabItem { Label("Home", systemImage: "house") }
                case .saved:
                    Color.blue.tabItem { Label("Home", systemImage: "house") }
                case .profile:
                    Color.yellow.tabItem { Label("Home", systemImage: "house") }
                }
            }
        }
    }
}
