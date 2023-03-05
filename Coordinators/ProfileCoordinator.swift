import UIKit

class ProfileCoordinator {
    var navigator: UINavigationController
    private var state: ProfileCoordinatorState
    private var appCoordinator: AppCoordinator

    init(with navigator: UINavigationController, state: ProfileCoordinatorState) {
        self.navigator = navigator
        navigator.navigationBar.isHidden = true
        self.state = state
        self.appCoordinator = AppCoordinator(with: navigator, state: .initial)
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
        
        case .willShowAppCoordinatorFlow:
            goToAppFlow()
            
        case .initial, .didShowProfileFlow:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: ProfileCoordinatorState) -> ProfileCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowProfileFlow
            
        case .didShowProfileFlow(let profileOutput):
            switch profileOutput {
            case .logout:
                return .willShowAppCoordinatorFlow
            }
            
        default:
            return nextState
        }
    }

    private func goToProfileFlow() {
        let vc = ProfileBuilder {_ in}.build()
        navigator.pushViewController(vc, animated: true)
    }
    
    private func goToAppFlow() {
        appCoordinator.start()
    }
}

enum ProfileCoordinatorState {
    case initial
    case didShowProfileFlow(profileOutput: ProfileOutput)
    case willShowProfileFlow
    case willShowAppCoordinatorFlow
}
