import SwiftUI
import DesignSystem

struct HomeView: View {
    
    @State private var categoriesSrollPosition: Int?
    @State private var nearToYouSrollPosition: Int?
    
    @ObservedObject
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        MemoryScrollView(
            scrollPosition: $nearToYouSrollPosition,
            axis: .vertical,
            items: (0..<10).map { index in
                ZStack {
                    Color.red
                    Text("\(index)")
                }
                .frame(height: 300.0)
            }
        )
    }
}

private extension HomeView {
    
    var headerText: some View {
        VStack(alignment: .leading, spacing: .zero) {
            welcomeText
            aroundYouText
        }
        .padding(.horizontal, Spacing.padding_2)
    }
    
    var welcomeText: some View {
        SFProText(
            text: "Hello, Sasmita",
            style: .sapphire,
            size: 32.0,
            isBold: true
        )
    }
    
    var aroundYouText: some View {
        SFProText(
            text: "There are 32 events\naround your location.",
            style: .mediumSlateBlue,
            size: 32.0,
            isBold: true
        )
    }
}
