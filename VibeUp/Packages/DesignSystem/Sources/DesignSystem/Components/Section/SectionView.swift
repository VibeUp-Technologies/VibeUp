import SwiftUI

public struct SectionView<Content: View>: View {
    
    public struct TrailingContent {
        
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
    
    private let title: String
    private let trailingContent: TrailingContent?
    private let content: () -> Content
    
    public init(
        title: String,
        trailingContent: TrailingContent? = nil,
        content: @escaping () -> Content
    ) {
        self.title = title
        self.trailingContent = trailingContent
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_2) {
            HStack(spacing: .zero) {
                SFProText(text: title, style: .sapphire, size: 22.0, isBold: true)
                Spacer()
                trailingContentView
            }
            .padding(.horizontal, Spacing.padding_2)
            
            content()
        }
    }
}

// MARK: - Private

private extension SectionView {
    
    @ViewBuilder
    var trailingContentView: some View {
        if let trailingContent {
            Button(
                action: trailingContent.onAction,
                label: {
                    SFProText(text: trailingContent.title, style: .sapphire, size: 14.0)
                }
            )
        }
    }
}
