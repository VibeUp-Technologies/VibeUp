import SwiftUI

public struct LightEventCell: View {
    
    private let image: URL?
    private let title: String
    private let date: String
    private let location: String
    private let price: String
    private let showDivider: Bool
    private let isBookmarkShown: Bool
    private let isFavorite: Bool
    private let isLoading: Bool
    private let onFavorite: () -> Void
    
    public init(
        image: URL?,
        title: String,
        date: String,
        location: String,
        price: String,
        showDivider: Bool,
        isBookmarkShown: Bool,
        isFavorite: Bool,
        isLoading: Bool,
        onFavorite: @escaping () -> Void
    ) {
        self.image = image
        self.title = title
        self.date = date
        self.location = location
        self.price = price
        self.showDivider = showDivider
        self.isBookmarkShown = isBookmarkShown
        self.isFavorite = isFavorite
        self.isLoading = isLoading
        self.onFavorite = onFavorite
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_1) {
            HStack(spacing: Spacing.padding_2) {
                imageView
                infoView
                Spacer()
                bookmarkView
            }
            if showDivider {
                Divider()
            }
        }
    }
}

// MARK: - Private

private extension LightEventCell {
    
    var imageView: some View {
        LazyImage(url: image)
            .cornerRadius(Spacing.padding_1_5)
            .frame(width: 100.0, height: 100.0)
    }
    
    var infoView: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_1) {
            SFProText(text: title, style: .sapphire, size: 16.0, isBold: true)
            
            VStack(alignment: .leading, spacing: Spacing.padding_0_5) {
                SFProText(text: date, style: .sapphire, size: 14.0)
                SFProText(text: location, style: .sapphire, size: 14.0)
                SFProText(text: price, style: .mediumSlateBlue, size: 14.0, isBold: true)
            }
        }
    }
    
    @ViewBuilder
    var bookmarkView: some View {
        if isBookmarkShown {
            Button(
                action: onFavorite,
                label: {
                    Group {
                        if isLoading {
                            ProgressView()
                        } else {
                            isFavorite ? Resources.Image.bookmarkFill : Resources.Image.bookmark
                        }
                    }
                    .font(.system(size: 18.0))
                    .foregroundStyle(Resources.Colors.sapphire)
                }
            )
            .padding(.trailing, Spacing.padding_1)
        }
    }
}
