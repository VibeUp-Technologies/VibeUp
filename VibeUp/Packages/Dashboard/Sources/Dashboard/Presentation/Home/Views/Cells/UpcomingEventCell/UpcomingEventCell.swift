import SwiftUI
import DesignSystem

struct UpcomingEventCell: View {
    
    private let title: String
    private let price: String
    private let location: String
    
    init(
        title: String,
        price: String,
        location: String
    ) {
        self.title = title
        self.price = price
        self.location = location
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_1) {
            ZStack(alignment: .topLeading) {
                Color.black
                    .cornerRadius(Spacing.padding_1_5)
                    .frame(width: 260.0, height: 180.0)
                
                VStack(spacing: .zero) {
                    SFProText(text: "Aug", style: .sapphire, size: 14.0)
                    SFProText(text: "24", style: .sapphire, size: 16.0, isBold: true)
                }
                .padding(.horizontal, Spacing.padding_1_5)
                .padding(.vertical, Spacing.padding_1)
                .background(
                    Color.white
                        .cornerRadius(Spacing.padding_1_5)
                        .overlay(
                            RoundedRectangle(cornerRadius: Spacing.padding_1_5)
                                .stroke(.gray.opacity(0.25), lineWidth: 1)
                        )
                        .padding(.vertical, Spacing.padding_0_25)
                )
                .padding(.top, Spacing.padding_1)
                .padding(.leading, Spacing.padding_1_5)
            }
            
            SFProText(text: title, style: .sapphire, size: 18.0, isBold: true)
            SFProText(text: price, style: .mediumSlateBlue, size: 18.0, isBold: true)
            
            HStack(spacing: Spacing.padding_0_5) {
                Resourses.Image.mappin
                    .font(.system(size: 14.0))
                    .foregroundStyle(Resourses.Colors.sapphire)
                
                SFProText(text: location, style: .sapphire, size: 14.0)
            }
        }
    }
}
