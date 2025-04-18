import SwiftUI

public struct MediumSlateBlueGradientView: View {
    
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

private extension MediumSlateBlueGradientView {
    
    var gradinet: Gradient {
        Gradient(
            colors: [
                Color(.mediumSlateBlue).opacity(0.25),
                .white,
                .white
            ]
        )
    }
}
