import UIKit

class ProfileCoordinator {
    var navigator: UINavigationController
    private var state: ProfileCoordinatorState

    init(with navigator: UINavigationController, state: ProfileCoordinatorState) {
        self.navigator = navigator
        self.state = state
    }
    
    func manageProfileInternalNavigation(with profileOutput: ProfileOutput) {
        self.state = .didShowProfileFlow(profileOutput: profileOutput)
        self.loop()
    }

    func start() {
        self.loop()
    }

    private func loop() {
        state = next(state)
        switch state {
        case .willShowProfileFlow:
            goToProfileFlow()
        
        case .initial, .didShowProfileFlow:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: ProfileCoordinatorState) -> ProfileCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowProfileFlow
            
        case .didShowProfileFlow(let favouritesOutput):
            switch favouritesOutput {
                default:
                    break
            }
            
        default:
            return nextState
        }
    }

    private func goToProfileFlow() {
        let vc = ProfileBuilder {_ in}.build()
        navigator.pushViewController(vc, animated: true)
    }
}

enum ProfileCoordinatorState {
    case initial
    case didShowProfileFlow(profileOutput: ProfileOutput)
    case willShowProfileFlow
}
