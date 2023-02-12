import UIKit

class HomeCoordinator {
    var navigator: UINavigationController
    private var state: HomeCoordinatorState

    init(with navigator: UINavigationController, state: HomeCoordinatorState) {
        self.navigator = navigator
        self.state = state
    }
    
    func manageHomeInternalNavigation(with homeOutput: HomeOutput) {
        self.state = .didShowHomeFlow(homeOutput: homeOutput)
        self.loop()
    }

    func start() {
        self.loop()
    }

    private func loop() {
        state = next(state)
        switch state {
        case .willShowHomeFlow:
            self.goToHomeFlow()

        case .initial, .didShowHomeFlow:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: HomeCoordinatorState) -> HomeCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowHomeFlow
            
        case .didShowHomeFlow(_):
            return nextState
            
        default:
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
    case didShowHomeFlow(homeOutput: HomeOutput)
    case willShowHomeFlow
}
