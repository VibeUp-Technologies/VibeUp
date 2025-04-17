import SwiftUI
import SDWebImageSwiftUI

public struct LazyImage: View {
    
    private let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        WebImage(url: url)
            .resizable()
            .indicator(.activity)
            .scaledToFit()
    }
}
