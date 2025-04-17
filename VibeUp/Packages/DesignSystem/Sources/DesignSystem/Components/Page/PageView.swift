import UIKit
import SwiftUI

public struct PageView: UIViewControllerRepresentable {
    
    @Binding private var selectedIndex: Int
    
    private let pages: [AnyView]
    
    public init(
        selectedIndex: Binding<Int>,
        pages: [AnyView]
    ) {
        _selectedIndex = selectedIndex
        
        self.pages = pages
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIPageViewController {
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        controller.dataSource = context.coordinator
        controller.delegate = context.coordinator
        return controller
    }

    public func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let current = context.coordinator.controller(by: selectedIndex)
        let direction = makeDirection(pageViewController, context: context)
        
        pageViewController.setViewControllers(
            [current],
            direction: direction,
            animated: true
        )
    }
}

// MARK: - Private

private extension PageView {
    
    func makeDirection(_ pageViewController: UIPageViewController, context: Context) -> UIPageViewController.NavigationDirection {
        guard
            let visibleController = pageViewController.viewControllers?.first,
            let currentIndex = context.coordinator.firstIndex(of: visibleController)
        else {
            return .forward
        }
        
        return selectedIndex >= currentIndex ? .forward : .reverse
    }
}

// MARK: - Coordinator

public extension PageView {
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        private let parent: PageView
        private let controllers: [UIViewController]

        init(_ pageViewController: PageView) {
            self.parent = pageViewController
            self.controllers = pageViewController.pages.map {
                let hostingController = UIHostingController(rootView: $0)
                hostingController.view.backgroundColor = .clear
                return hostingController
            }
        }
        
        func firstIndex(of controller: UIViewController) -> Int? {
            controllers.firstIndex(of: controller)
        }
        
        func controller(by index: Int) -> UIViewController {
            controllers[index]
        }

        public func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
            return controllers[index - 1]
        }

        public func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), index + 1 < controllers.count else { return nil }
            return controllers[index + 1]
        }

        public func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool
        ) {
            if completed,
               let visibleController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleController) {
                parent.selectedIndex = index
            }
        }
    }
}
