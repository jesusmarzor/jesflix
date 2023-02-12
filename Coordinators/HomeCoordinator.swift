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
            goToHomeFlow()
            
        case .willShowEntertainmentDetail(let entertainment):
            showEntertainmentDetail(entertainment: entertainment)

        case .initial, .didShowHomeFlow:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: HomeCoordinatorState) -> HomeCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowHomeFlow
            
        case .didShowHomeFlow(let homeOutput):
            switch homeOutput {
            case .goToEntertainmentDetail(entertainment: let entertainment):
                return .willShowEntertainmentDetail(entertainment: entertainment)
            }
            
        default:
            return nextState
        }
    }

    private func goToHomeFlow() {
        let vc = HomeBuilder {_ in}.build()
        navigator.pushViewController(vc, animated: true)
    }
    
    private func showEntertainmentDetail(entertainment: EntertainmentProtocol) {
        let vc = EntertainmentDetailBuilder(entertainment: entertainment) { _ in }.build()
        vc.modalPresentationStyle = .overFullScreen
        navigator.present(vc, animated: true)
    }
}

enum HomeCoordinatorState {
    case initial
    case didShowHomeFlow(homeOutput: HomeOutput)
    case willShowHomeFlow
    case willShowEntertainmentDetail(entertainment: EntertainmentProtocol)
}
