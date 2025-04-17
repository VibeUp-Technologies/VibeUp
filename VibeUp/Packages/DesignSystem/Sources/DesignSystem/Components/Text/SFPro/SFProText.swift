import SwiftUI

public struct SFProText: View {
    
    public enum Style {
        case `default`
        case sapphire
        case mediumSlateBlue
    }
    
    private let text: String
    private let style: Style
    private let size: CGFloat
    private let isBold: Bool
    
    public init(
        text: String,
        style: Style = .default,
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
            .foregroundStyle(style.color)
    }
}

// MARK: - Private

private extension SFProText.Style {
    
    var color: Color {
        switch self {
        case .default:
            .white
        case .sapphire:
            Resourses.Colors.sapphire
        case .mediumSlateBlue:
            Resourses.Colors.mediumSlateBlue
        }
    }
}

// MARK: - Preview

#Preview {
    SFProText(text: "Test", style: .sapphire)
}
