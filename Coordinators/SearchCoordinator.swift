import UIKit

class SearchCoordinator {
    var navigator: UINavigationController
    private var state: SearchCoordinatorState

    init(with navigator: UINavigationController, state: SearchCoordinatorState) {
        self.navigator = navigator
        self.state = state
    }
    
    func manageSearchInternalNavigation(with searchOutput: SearchOutput) {
        self.state = .didShowSearchFlow(searchOutput: searchOutput)
        self.loop()
    }

    func start() {
        self.loop()
    }

    private func loop() {
        state = next(state)
        switch state {
        case .willShowSearchFlow:
            goToSearchFlow()
            
        case .willShowEntertainmentDetail(let entertainment):
            showEntertainmentDetail(entertainment: entertainment)

        case .initial, .didShowSearchFlow:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: SearchCoordinatorState) -> SearchCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowSearchFlow
            
        case .didShowSearchFlow(let searchOutput):
            switch searchOutput {
            case .goToEntertainmentDetail(entertainment: let entertainment):
                return .willShowEntertainmentDetail(entertainment: entertainment)
            }
            
        default:
            return nextState
        }
    }

    private func goToSearchFlow() {
        let vc = SearchBuilder {_ in}.build()
        navigator.pushViewController(vc, animated: true)
    }
    
    private func showEntertainmentDetail(entertainment: EntertainmentProtocol) {
        let vc = EntertainmentDetailBuilder(entertainment: entertainment) { _ in }.build()
        vc.modalPresentationStyle = .overFullScreen
        navigator.present(vc, animated: true)
    }
}

enum SearchCoordinatorState {
    case initial
    case didShowSearchFlow(searchOutput: SearchOutput)
    case willShowSearchFlow
    case willShowEntertainmentDetail(entertainment: EntertainmentProtocol)
}
