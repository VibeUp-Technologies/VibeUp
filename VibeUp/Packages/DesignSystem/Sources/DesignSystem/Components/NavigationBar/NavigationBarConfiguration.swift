import SwiftUI
public struct NavigationBarConfiguration {
    
    let leadingItems: [any NavigationBarItemButtonRepresentation]
    let trailingItems: [any NavigationBarItemButtonRepresentation]
    let isBackgroundHidden: Bool
    let isHidden: Bool
    
    public init(
        leadingItems: [any NavigationBarItemButtonRepresentation] = [],
        trailingItems: [any NavigationBarItemButtonRepresentation] = [],
        isBackgroundHidden: Bool = false,
        isHidden: Bool = false
    ) {
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.isBackgroundHidden = isBackgroundHidden
        self.isHidden = isHidden
    }
}
