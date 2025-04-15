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
    
    @State private var selectedTabIndex: Int = 0
    
    init(tabs: [Tab]) {
        self.tabs = tabs
    }
    
    var body: some View {
        VStack(spacing: Spacing.padding_0_5) {
            ZStack(alignment: .top) {
                BackgroundGradientView()
                    .ignoresSafeArea()
                
                TabView(selection: $selectedTabIndex) {
                    ForEach(tabs.indices, id: \.self) { index in
                        switch tabs[index] {
                        case .home(let coordinator):
                            DashboardCoordinatorView(coordinator: coordinator).id(index)
                        case .explore:
                            Color.green.id(index)
                        case .saved:
                            Color.blue.id(index)
                        case .profile:
                            Color.yellow.id(index)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .transition(.slide)
                .animation(.easeInOut(duration: 1.0), value: selectedTabIndex)
            }
            ZStack {
                Color.clear
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
                                    selectedTabIndex = index
                                },
                                label: {
                                    HStack(spacing: Spacing.padding_0_5) {
                                        Image(systemName: "house")
                                        
                                        if selectedTabIndex == index {
                                            SFProText(text: "Home", style: .sapphire)
                                        }
                                    }
                                    .background(
                                        Group {
                                            if selectedTabIndex == index {
                                                Color.red
                                                    .cornerRadius(Spacing.padding_2)
                                                    .padding(-Spacing.padding_1)
                                            }
                                        }
                                    )
                                    .animation(.easeInOut(duration: 0.3), value: selectedTabIndex)
                                }
                            )
                            
                        }
                    }
                }
                .padding(.horizontal, Spacing.padding_2)
            }
            .padding(.horizontal, Spacing.padding_1_5)
        }
    }
}
