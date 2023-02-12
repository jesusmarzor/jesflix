import UIKit

class TabBarCoordinator {
    var navigator: UINavigationController
    private var state: TabBarCoordinatorState
    private var homeChildCoordinator: HomeCoordinator?

    init(with navigator: UINavigationController, state: TabBarCoordinatorState) {
        self.navigator = navigator
        self.state = state
    }
    
    private func buildHomeTabBarModule() -> UINavigationController {
        let homeVC = HomeBuilder() { [weak self] output in
            self?.homeChildCoordinator?.manageHomeInternalNavigation(with: output)
        }.build()

        let homeNavController = UINavigationController(rootViewController: homeVC)

        homeChildCoordinator = HomeCoordinator(with: homeNavController, state: .initial)

        return homeNavController
    }
    
    func buildTabBarItems() -> [UINavigationController] {
        let vc1 = buildHomeTabBarModule()
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        
        vc1.title = "home"
        
        return [vc1]
    }

    func start() {
        self.loop()
    }

    private func loop() {
        state = next(state)
        switch state {
        case .willShowTabBar:
            self.showTabBar()

        case .initial:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: TabBarCoordinatorState) -> TabBarCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowTabBar

        case .willShowTabBar:
            return nextState
        }
    }

    private func showTabBar() {
        let vc = TabBarBuilder(tabs: buildTabBarItems()).build()
        navigator.navigationBar.isHidden = true
        navigator.setViewControllers([vc], animated: true)
    }
}

enum TabBarCoordinatorState {
    case initial
    case willShowTabBar
}

struct TabBarItem {
    let label: String
    let icon: UIImage
    let vc: UINavigationController
}
