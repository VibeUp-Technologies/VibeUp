import SwiftUI
import FlowStacks
import DesignSystem

public struct DashboardView: View {
    
    @ObservedObject
    private var coordinator: DashboardCoordinator
    
    public init(coordinator: DashboardCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        FlowStack($coordinator.routes) {
            ZStack(alignment: .top) {
                BackgroundGradientView()
                
                VStack(alignment: .leading, spacing: .zero) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16.0) {
                            Color.red.frame(width: 100.0)
                            Color.red.frame(width: 100.0)
                            Color.red.frame(width: 100.0)
                            Color.red.frame(width: 100.0)
                        }
                        .frame(height: 80.0)
                        .padding(.leading, 16.0)
                    }
                    Spacer()
                }
            }
            .navigationBar()
        }
    }
}
