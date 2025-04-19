import SwiftUI
import SDWebImageSwiftUI

public struct LazyImage: View {
    
    private let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        Color.clear
            .background(
                WebImage(
                    url: url,
                    content: { image in
                        image.resizable().scaledToFill()
                    },
                    placeholder: {
                        Resources.Colors.sapphire.opacity(0.15).shimmering()
                    }
                )
            )
    }
}
