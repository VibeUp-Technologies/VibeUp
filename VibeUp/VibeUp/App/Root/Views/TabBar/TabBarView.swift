import SwiftUI
import DesignSystem
import Dashboard
import Explore
import Favorites

struct TabBarView: View {
    
    enum Tab {
        case home(DashboardCoordinator)
        case explore(ExploreCoordinator)
        case favorites(FavoritesCoordinator)
        case profile
    }
    
    private let tabs: [Tab]
    
    @State private var selectedIndex: Int = 0
    
    init(tabs: [Tab]) {
        self.tabs = tabs
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            MediumSlateBlueGradientView()
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                PageView(selectedIndex: $selectedIndex, pages: pages)
                    .overlay(alignment: .bottom, content: { bottomGradient })
                    .padding(.bottom, -Constants.tabBarHeight * 0.5)
                
                tabBarView
            }
        }
    }
}

// MARK: - Privare

private extension TabBarView {
    
    var tabBarView: some View {
        ZStack {
            Color.white
                .frame(height: Constants.tabBarHeight)
                .cornerRadius(Constants.tabBarHeight * 0.5)
                .shadow(radius: Constants.shadowRadious)
            
            HStack(spacing: Spacing.padding_1) {
                ForEach(tabs.indices, id: \.self) { index in
                    TabFactory.makeTabItemView(
                        by: tabs[index],
                        isSelected: selectedIndex == index,
                        action: {
                            selectedIndex = index
                        }
                    )
                }
            }
            .padding(.horizontal, Spacing.padding_2)
        }
        .padding(.horizontal, Spacing.padding_2)
    }
    
    var pages: [AnyView] {
        tabs.map { TabFactory.makePageView(by: $0).eraseToAnyView() }
    }
    
    var bottomGradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .clear,
                    .white
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 20.0)
    }
}

// MARK: - TabFactory

private extension TabBarView {
    
    enum TabFactory {
        
        @ViewBuilder
        static func makePageView(by tab: Tab) -> some View {
            switch tab {
            case let .home(coordinator):
                DashboardCoordinatorView(coordinator: coordinator)
            case let .explore(coordinator):
                ExploreCoordinatorView(coordinator: coordinator)
            case let .favorites(coordinator):
                FavoritesCoordinatorView(coordinator: coordinator)
            case .profile:
                Color.yellow
            }
        }
        
        @ViewBuilder
        static func makeTabItemView(by tab: Tab, isSelected: Bool, action: @escaping () -> Void) -> some View {
            switch tab {
            case .home:
                TabItemView(
                    isSelected: isSelected,
                    image: Resources.Image.homeFill,
                    name: "Home",
                    action: action
                )
            case .explore:
                TabItemView(
                    isSelected: isSelected,
                    image: Resources.Image.compassFill,
                    name: "Explore",
                    action: action
                )
            case .favorites:
                TabItemView(
                    isSelected: isSelected,
                    image: Resources.Image.heartFill,
                    name: "Favorites",
                    action: action
                )
            case .profile:
                TabItemView(
                    isSelected: isSelected,
                    image: Resources.Image.profileFill,
                    name: "Profile",
                    action: action
                )
            }
        }
    }
}

// MARK: - Constants

private extension TabBarView {
    
    enum Constants {
        static let shadowRadious: CGFloat = 6.0
        static let tabBarHeight: CGFloat = 72.0
    }
}
