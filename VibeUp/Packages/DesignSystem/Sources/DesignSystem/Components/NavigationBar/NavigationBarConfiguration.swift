import SwiftUI

public enum NavigationBarItem {
    
    case button(any NavigationBarItemButtonRepresentation)
}

public struct NavigationBarConfiguration {
    
    let leadingItems: [NavigationBarItem]
    let trailingItems: [NavigationBarItem]
    let isBackgroundHidden: Bool
    
    public init(
        leadingItems: [NavigationBarItem] = [],
        trailingItems: [NavigationBarItem] = [],
        isBackgroundHidden: Bool = false
    ) {
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.isBackgroundHidden = isBackgroundHidden
    }
}
