import SwiftUI

struct TabBarView: View {
    
    enum Tab {
        case home(HomeViewModel)
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
                case .home(let viewModel):
                    HomeView(viewModel: viewModel).tabItem { Label("Home", systemImage: "house") }
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

final class HomeViewModel {
    
}

struct HomeView: View {
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Color.red
    }
}
