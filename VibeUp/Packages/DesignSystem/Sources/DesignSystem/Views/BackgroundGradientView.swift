import SwiftUI

public struct BackgroundGradientView: View {
    
    public init() { }
    
    public var body: some View {
        LinearGradient(
            gradient: gradinet,
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Private

private extension BackgroundGradientView {
    
    var gradinet: Gradient {
        Gradient(
            colors: [
                Color(.mediumSlateBlue).opacity(0.5),
                .white,
                .white
            ]
        )
    }
}
