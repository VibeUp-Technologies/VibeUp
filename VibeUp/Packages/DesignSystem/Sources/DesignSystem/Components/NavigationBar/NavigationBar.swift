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
    func makeNavigationBarItemContent(items: [any NavigationBarItemButtonRepresentation]) -> some View {
        HStack(spacing: Spacing.padding_1) {
            ForEach(items.indices, id: \.self) { index in
                items[index].eraseToAnyView()
            }
        }
    }
}
