import UIKit

class HomeCoordinator {
    var navigator: UINavigationController
    private var state: HomeCoordinatorState

    init(with navigator: UINavigationController, state: HomeCoordinatorState) {
        self.navigator = navigator
        self.state = state
    }

    func start() {
        self.loop()
    }

    private func loop() {
        self.state = next(self.state)
        switch  self.state {
        case .willShowHomeFlow:
            self.goToHomeFlow()

        case .initial:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: HomeCoordinatorState) -> HomeCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowHomeFlow

        case .willShowHomeFlow:
            return nextState
        }
    }

    private func goToHomeFlow() {
        let vc = HomeBuilder {_ in}.build()
        navigator.pushViewController(vc, animated: true)
    }
}

enum HomeCoordinatorState {
    case initial
    case willShowHomeFlow
}
