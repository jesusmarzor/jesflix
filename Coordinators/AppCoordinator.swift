import UIKit

class AppCoordinator {
    var navigator: UINavigationController
    private var state: AppCoordinatorState
    private let tabBarChildCoordinator: TabBarCoordinator

    init(with navigator: UINavigationController, state: AppCoordinatorState) {
        self.navigator = navigator
        navigator.navigationBar.isHidden = true
        self.state = state
        self.tabBarChildCoordinator = TabBarCoordinator(with: navigator, state: .initial)
    }

    func start() {
        self.loop()
    }

    private func loop() {
        self.state = next(self.state)
        switch  self.state {
        case .willShowLoginFlow:
            self.goToLoginFlow()

        case .initial:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: AppCoordinatorState) -> AppCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowLoginFlow

        case .willShowLoginFlow:
            return nextState
        }
    }

    private func goToLoginFlow() {
        let vc = LoginBuilder { _ in
            self.tabBarChildCoordinator.start()
        }.build()
        navigator.setViewControllers([vc], animated: false)
    }
}

enum AppCoordinatorState {
    case initial
    case willShowLoginFlow
}
