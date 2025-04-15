import SwiftUI

public struct BackNavigationBarItemButton: NavigationBarItemButtonRepresentation {
    
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        NavigationBarItemButton(
            imageName: "arrow.backward",
            action: action
        )
    }
}

#Preview {
    BackNavigationBarItemButton(action: { })
}
