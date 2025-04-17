import SwiftUI

public extension View {
    
    func onFirstAppear(_ onAction: @escaping () -> ()) -> some View {
        modifier(OnFirstAppearModifier(onAction))
    }
}

private struct OnFirstAppearModifier: ViewModifier {

    private let onAction: () -> ()
    
    @State private var hasAppeared = false
    
    init(_ onAction: @escaping () -> ()) {
        self.onAction = onAction
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                
                hasAppeared = true
                
                onAction()
            }
    }
}
