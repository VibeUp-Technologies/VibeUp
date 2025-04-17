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
                    LazyHStack(spacing: Spacing.padding_2) {
                        ForEach(viewModel.categories.indices, id: \.self) { index in
                            CategoryCell(title: viewModel.categories[index].name, image: Resourses.Image.musicNote)
                        }
                    }
                    .padding(.leading, 16.0)
                }
                
                SectionView(
                    title: "Upcoming Events",
                    trailingContent: .init(
                        title: "See all events",
                        onAction: { }
                    ),
                    content: {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: Spacing.padding_2) {
                                UpcomingEventCell(title: "Bernadya Solo Concert", price: "Rp250k - Rp500k", location: "Mojokerto, East Jave")
                                UpcomingEventCell(title: "Moshig Fest", price: "Rp80k - Rp250k", location: "Jombang, East Jave")
                            }
                            .padding(.horizontal, 16.0)
                        }
                    }
                )
                
                SectionView(
                    title: "Popular Events",
                    trailingContent: .init(
                        title: "See all events",
                        onAction: { }
                    ),
                    content: {
                        LazyVStack(spacing: Spacing.padding_2) {
                            Color.black.frame(height: 220.0).cornerRadius(Spacing.padding_1_5)
                            Color.black.frame(height: 220.0).cornerRadius(Spacing.padding_1_5)
                            Color.black.frame(height: 220.0).cornerRadius(Spacing.padding_1_5)
                        }
                        .padding(.horizontal, 16.0)
                    }
                )
            }
            .padding(.top, Spacing.padding_3)
            .padding(.bottom, Spacing.padding_5)
        }
        .onFirstAppear(viewModel.onFirstAppear)
    }
}

// MARK: - Private

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
