import SwiftUI

public struct MemoryScrollView<Item: View>: View {
    
    public enum Axis {
        case horizontal
        case vertical
    }
    
    @Binding private var scrollPosition: Int?
    
    private let axis: Axis
    private let spacing: CGFloat
    private let showsIndicators: Bool
    private let items: [Item]
    
    public init(
        scrollPosition: Binding<Int?>,
        axis: Axis,
        spacing: CGFloat = Spacing.padding_1,
        showsIndicators: Bool = false,
        items: [Item]
    ) {
        self._scrollPosition = scrollPosition
        
        self.axis = axis
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.items = items
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(axis.scrollAxis, showsIndicators: showsIndicators) {
                container
            }
            .onAppear {
                if let position = scrollPosition {
                    proxy.scrollTo(position, anchor: axis.scrollAnchor)
                }
            }
        }
    }
}

// MARK: - Private

private extension MemoryScrollView {
    
    @ViewBuilder
    var container: some View {
        switch axis {
        case .horizontal:
            LazyHStack(spacing: spacing, content: { content })
        case .vertical:
            LazyVStack(spacing: spacing, content: { content })
        }
    }
    
    var content: some View {
        ForEach(items.indices, id: \.self) { index in
            items[index]
                .id(index)
                .onAppear {
                    scrollPosition = index
                }
        }
        .padding(.horizontal, Spacing.padding_2)
    }
}

// MARK: - Axis

private extension MemoryScrollView.Axis {
    
    var scrollAxis: Axis.Set {
        switch self {
        case .horizontal: .horizontal
        case .vertical: .vertical
        }
    }
    
    var scrollAnchor: UnitPoint {
        switch self {
        case .horizontal: .leading
        case .vertical: .center
        }
    }
}
