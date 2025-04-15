import SwiftUI

struct NavigationBar: ToolbarContent {
    
    let configuration: NavigationBarConfiguration
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            makeNavigationBarItemContent(items: configuration.leadingItems)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            makeNavigationBarItemContent(items: configuration.trailingItems)
        }
    }
}

// MARK: - Private

private extension NavigationBar {
    
    @ViewBuilder
    func makeNavigationBarItemContent(items: [NavigationBarItem]) -> some View {
        HStack(spacing: Spacing.padding_1) {
            ForEach(items.indices, id: \.self) { index in
                switch items[index] {
                case .button(let view):
                    view.eraseToAnyView()
                }
            }
        }
    }
}
