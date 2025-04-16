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
    
    private let columns = [
        GridItem(.adaptive(minimum: 80.0))
    ]
    
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
                    .padding(.bottom, -Spacing.padding_2)
                
                tabBarView
            }
        }
    }
}

// MARK: - Privare

private extension TabBarView {
    
    var tabBarView: some View {
        ZStack {
            Color.yellow
                .frame(height: 64)
                .cornerRadius(32.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 32.0)
                        .stroke(.gray, lineWidth: 1)
                )
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(tabs.indices, id: \.self) { index in
                    VStack(spacing: Spacing.padding_1) {
                        Button(
                            action: {
                                selectedIndex = index
                            },
                            label: {
                                HStack(spacing: Spacing.padding_0_5) {
                                    Image(systemName: "house")
                                    
                                    if selectedIndex == index {
                                        SFProText(text: "Home", style: .sapphire)
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
                                .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                            }
                        )
                        
                    }
                }
            }
            .padding(.horizontal, Spacing.padding_2)
        }
        .padding(.horizontal, Spacing.padding_1_5)
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
