import SwiftUI
import DesignSystem

struct TabItemView: View {
    
    private let isSelected: Bool
    private let image: Image
    private let name: String
    private let action: () -> Void
    
    init(
        isSelected: Bool,
        image: Image,
        name: String,
        action: @escaping () -> Void
    ) {
        self.isSelected = isSelected
        self.image = image
        self.name = name
        self.action = action
    }
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack(spacing: Spacing.padding_0_5) {
                    image
                        .font(.system(size: 18.0))
                        .foregroundStyle(isSelected ? .white : Resourses.Colors.mediumSlateBlue)
                    
                    if isSelected {
                        SFProText(text: name, size: 14.0)
                    }
                }
                .background(
                    Group {
                        if isSelected {
                            Resourses.Colors.mediumSlateBlue
                                .cornerRadius(Spacing.padding_2_5)
                                .padding(-Spacing.padding_1)
                        }
                    }
                )
            }
        )
        .frame(maxWidth: .infinity)
        .animation(
            .easeInOut(duration: Constants.animationDuration),
            value: isSelected
        )
    }
}

// MARK: - Constants

private extension TabItemView {
    
    enum Constants {
        static let animationDuration: TimeInterval = 0.3
    }
}
