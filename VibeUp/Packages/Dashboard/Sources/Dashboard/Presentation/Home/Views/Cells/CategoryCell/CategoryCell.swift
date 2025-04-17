import SwiftUI
import DesignSystem

struct CategoryCell: View {
    
    private let title: String
    private let image: Image
    
    init(
        title: String,
        image: Image
    ) {
        self.title = title
        self.image = image
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
                .cornerRadius(Spacing.padding_1_5)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.padding_1_5)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                )
                .padding(.vertical, Spacing.padding_0_25)
            
            VStack(alignment: .leading, spacing: Spacing.padding_2) {
                image
                    .font(.system(size: 22.0))
                    .foregroundStyle(Resourses.Colors.sapphire)
                
                SFProText(text: title, style: .sapphire, size: 15.0)
            }
            .padding(.horizontal, Spacing.padding_2)
            .padding(.vertical, Spacing.padding_1_5)
        }
        .frame(width: 100.0)
    }
}
