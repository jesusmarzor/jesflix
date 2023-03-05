import UIKit

class TabBarCoordinator {
    var navigator: UINavigationController
    private var state: TabBarCoordinatorState
    private var homeChildCoordinator: HomeCoordinator?
    private var searchChildCoordinator: SearchCoordinator?
    private var favouritesChildCoordinator: FavouritesCoordinator?
    private var profileChildCoordinator: ProfileCoordinator?

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
    
    private func buildSearchTabBarModule() -> UINavigationController {
        let searchVC = SearchBuilder() { [weak self] output in
            self?.searchChildCoordinator?.manageSearchInternalNavigation(with: output)
        }.build()

        let searchNavController = UINavigationController(rootViewController: searchVC)

        searchChildCoordinator = SearchCoordinator(with: searchNavController, state: .initial)

        return searchNavController
    }
    
    private func buildFavouritesTabBarModule() -> UINavigationController {
        let favouritesVC = FavouritesBuilder() { [weak self] output in
            self?.favouritesChildCoordinator?.manageFavouritesInternalNavigation(with: output)
        }.build()

        let favouritesNavController = UINavigationController(rootViewController: favouritesVC)

        favouritesChildCoordinator = FavouritesCoordinator(with: favouritesNavController, state: .initial)

        return favouritesNavController
    }
    
    private func buildProfileTabBarModule() -> UINavigationController {
        let profileVC = ProfileBuilder() { [weak self] output in
            self?.profileChildCoordinator?.manageProfileInternalNavigation(with: output)
        }.build()

        let profileNavController = UINavigationController(rootViewController: profileVC)

        profileChildCoordinator = ProfileCoordinator(with: profileNavController, state: .initial)

        return profileNavController
    }
    
    func buildTabBarItems() -> [UINavigationController] {
        let vc1 = buildHomeTabBarModule()
        let vc2 = buildSearchTabBarModule()
        let vc3 = buildFavouritesTabBarModule()
        let vc4 = buildProfileTabBarModule()
        
        vc1.tabBarItem.image = UIImage(systemName: "house.circle.fill")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
        vc3.tabBarItem.image = UIImage(systemName: "star.circle.fill")
        vc4.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        
        vc1.title = String.getLabelForKey("common_home")
        vc2.title = String.getLabelForKey("common_search")
        vc3.title = String.getLabelForKey("common_favourites")
        vc4.title = String.getLabelForKey("common_profile")
        
        return [vc1, vc2, vc3, vc4]
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
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.pushViewController(vc, animated: true)
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
