import SwiftUI

public struct FullScreenMessageView: View {
    
    public struct ButtonConfiguration {
        
        let title: String
        let onAction: () -> Void
        
        public init(
            title: String,
            onAction: @escaping () -> Void
        ) {
            self.title = title
            self.onAction = onAction
        }
    }
    
    private let buttons: [ButtonConfiguration]
    
    public init(buttons: [ButtonConfiguration] = []) {
        self.buttons = buttons
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            ForEach(buttons.indices, id: \.self) { index in
                Button(
                    action: buttons[index].onAction,
                    label: {
                        Text(buttons[index].title)
                    }
                )
            }
            Spacer()
        }
    }
}
