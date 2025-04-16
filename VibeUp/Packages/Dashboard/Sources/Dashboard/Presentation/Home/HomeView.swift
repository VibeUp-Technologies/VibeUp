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
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: Spacing.padding_2) {
                headerText
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16.0) {
                        Color.red.frame(width: 100.0).onTapGesture(perform: viewModel.onTest)
                        Color.red.frame(width: 100.0)
                        Color.red.frame(width: 100.0)
                        Color.red.frame(width: 100.0)
                    }
                    .padding(.leading, 16.0)
                }
                .frame(height: 80.0)
                
                LazyVStack(spacing: 16.0) {
                    Color.red.frame(height: 300.0)
                    Color.red.frame(height: 300.0)
                    Color.red.frame(height: 300.0)
                    Color.red.frame(height: 300.0)
                }
                .padding(.horizontal, 16.0)
                
                Spacer()
            }
        }
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
