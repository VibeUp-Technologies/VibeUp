import SwiftUI

extension View {
    
    func shimmering() -> some View {
        modifier(Shimmer())
    }
}

struct Shimmer: ViewModifier {
    private let animation = Animation.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false)
    
    private let gradient = Gradient(colors: [
        .white,
        .clear,
        .white,
    ])
    
    private let min: CGFloat = -0.5
    private let max: CGFloat = 1.5
    
    @State private var isInitialState = true
    @Environment(\.layoutDirection) private var layoutDirection

    func body(content: Content) -> some View {
        content.mask(
            LinearGradient(
                gradient: gradient,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
        .animation(animation, value: isInitialState)
        .onAppear { isInitialState = false }
    }
}

private extension Shimmer {
    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }
}
