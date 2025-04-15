import SwiftUI

public extension View {
    
    func navigationBar() -> some View {
        NavigationStack {
            self.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Leading") {
                        // Button Action
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Trailing") {
                        // Button Action
                    }
                }
            }
            .toolbarBackground(.hidden)
        }
    }
}
