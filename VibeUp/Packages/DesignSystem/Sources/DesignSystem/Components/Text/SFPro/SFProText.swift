import SwiftUI

public struct SFProText: View {
    
    public enum Style {
        case sapphire
        case mediumSlateBlue
    }
    
    private let text: String
    private let style: Style
    private let size: CGFloat
    private let isBold: Bool
    
    public init(
        text: String,
        style: Style,
        size: CGFloat = 12.0,
        isBold: Bool = false
    ) {
        self.text = text
        self.style = style
        self.size = size
        self.isBold = isBold
    }
    
    public var body: some View {
        Text(text)
            .bold(isBold)
            .font(.system(size: size))
            .foregroundColor(style.color)
    }
}

// MARK: - Private

private extension SFProText.Style {
    
    var color: Color {
        switch self {
        case .sapphire:
            Color(.sapphire)
        case .mediumSlateBlue:
            Color(.mediumSlateBlue)
        }
    }
}

// MARK: - Preview

#Preview {
    SFProText(text: "Test", style: .sapphire)
}
