import SwiftUI
import DesignSystem

public struct HomeView: View {
    
    @ObservedObject
    private var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            BackgroundGradientView()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: Spacing.padding_2) {
                headerText
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16.0) {
                        Color.red.frame(width: 100.0)
                        Color.red.frame(width: 100.0)
                        Color.red.frame(width: 100.0)
                        Color.red.frame(width: 100.0)
                    }
                    .frame(height: 80.0)
                    .padding(.leading, 16.0)
                }
                Spacer()
            }
            .padding(.top, Spacing.padding_2)
        }
        .navigationBar(
            configuration: .init(
                leadingItems: [
                    .button(BackNavigationBarItemButton(action: { }))
                ],
                isBackgroundHidden: true
            )
        )
    }
}

private extension HomeView {
    
    var headerText: some View {
        VStack(alignment: .leading, spacing: .zero) {
            welcomeText
            aroundYouText
        }
        .padding([.top, .horizontal], Spacing.padding_2)
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
