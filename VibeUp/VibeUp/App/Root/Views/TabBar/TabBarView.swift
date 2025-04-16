import SwiftUI
import DesignSystem
import Dashboard

struct TabBarView: View {
    
    enum Tab {
        case home(DashboardCoordinator)
        case explore
        case saved
        case profile
    }
    
    private let tabs: [Tab]
    
    @State private var selectedIndex: Int = 0
    
    init(tabs: [Tab]) {
        self.tabs = tabs
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundGradientView()
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                PageView(selectedIndex: $selectedIndex, pages: pages)
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
                    Button(
                        action: {
                            selectedIndex = index
                        },
                        label: {
                            HStack(spacing: Spacing.padding_0_5) {
                                Image(systemName: "house")
                                
                                if selectedIndex == index {
                                    SFProText(text: "Home", style: .sapphire, size: 16.0, isBold: true)
                                }
                            }
                            .background(
                                Group {
                                    if selectedIndex == index {
                                        Color.red
                                            .cornerRadius(Spacing.padding_2)
                                            .padding(-Spacing.padding_1)
                                    }
                                }
                            )
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut(duration: Constants.animationDuration), value: selectedIndex)
                }
            }
            .padding(.horizontal, Spacing.padding_2)
        }
        .padding(.horizontal, Spacing.padding_2)
    }
    
    var pages: [AnyView] {
        tabs.map { makePageView(by: $0).eraseToAnyView() }
    }
    
    @ViewBuilder
    func makePageView(by tab: Tab) -> some View {
        switch tab {
        case .home(let coordinator):
            DashboardCoordinatorView(coordinator: coordinator)
        case .explore:
            Color.green
        case .saved:
            Color.blue
        case .profile:
            Color.yellow
        }
    }
}

// MARK: - Constants

private extension TabBarView {
    
    enum Constants {
        static let shadowRadious: CGFloat = 6.0
        static let tabBarHeight: CGFloat = 72.0
        static let animationDuration: TimeInterval = 0.3
    }
}
