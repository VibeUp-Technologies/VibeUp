import SwiftUI

public extension View {
    
    func navigationBar(configuration: NavigationBarConfiguration) -> some View {
        modifier(NavigationBarModifier(configuration: configuration))
    }
}

private struct NavigationBarModifier: ViewModifier {
    
    let configuration: NavigationBarConfiguration

    func body(content: Content) -> some View {
        content
            .toolbar {
                NavigationBar(configuration: configuration)
            }
            .toolbar(
                configuration.isHidden ? .hidden : .visible,
                for: .navigationBar
            )
            .toolbarBackground(
                configuration.isBackgroundHidden ? .hidden : .visible,
                for: .navigationBar
            )
            .navigationBarBackButtonHidden(true)
    }
}
