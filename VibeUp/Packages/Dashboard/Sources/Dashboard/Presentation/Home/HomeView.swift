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
        VStack(alignment: .leading, spacing: Spacing.padding_2) {
            yourLocation
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.padding_2) {
                    headerText
                    categoriesList
                    upcomingEventsList
                    popularEventsList
                }
                .padding(.bottom, Spacing.padding_6)
            }
        }
        .onFirstAppear(viewModel.onFirstAppear)
    }
}

// MARK: - Private

private extension HomeView {
    
    var yourLocation: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: Spacing.padding_0_5) {
                Resources.Image.locationFill
                    .font(.system(size: 12.0))
                    .foregroundStyle(Resources.Colors.sapphire)
                
                SFProText(text: "Your location", style: .sapphire, size: 12.0)
            }
            SFProText(text: "Los Angeles, CA", style: .sapphire, size: 18.0, isBold: true)
        }
        .padding(.horizontal, Spacing.padding_2)
    }
    
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
            text: "There are \(viewModel.totalNumberOfEvents) events\naround your location.",
            style: .mediumSlateBlue,
            size: 32.0,
            isBold: true
        )
    }
    
    var categoriesList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: Spacing.padding_2) {
                ForEach(viewModel.categoryViewModels, content: CategoryCell.init)
            }
            .padding(.horizontal, Spacing.padding_2)
        }
    }
    
    var upcomingEventsList: some View {
        SectionView(
            title: "Upcoming Events",
            trailingContent: .init(
                title: "See all events",
                onAction: { }
            ),
            content: {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: Spacing.padding_2) {
                        ForEach(viewModel.upcomingEventViewModels, content: UpcomingEventCell.init)
                    }
                    .padding(.horizontal, Spacing.padding_2)
                }
            }
        )
    }
    
    var popularEventsList: some View {
        SectionView(
            title: "Popular Events",
            trailingContent: .init(
                title: "See all events",
                onAction: { }
            ),
            content: {
                LazyVStack(spacing: Spacing.padding_1) {
                    ForEach(viewModel.popularEventViewModels, content: PopularEventCell.init)
                }
                .padding(.horizontal, Spacing.padding_2)
            }
        )
    }
}
