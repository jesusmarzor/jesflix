import UIKit

class FavouritesCoordinator {
    var navigator: UINavigationController
    private var state: FavouritesCoordinatorState

    init(with navigator: UINavigationController, state: FavouritesCoordinatorState) {
        self.navigator = navigator
        self.state = state
    }
    
    func manageFavouritesInternalNavigation(with favouritesOutput: FavouritesOutput) {
        self.state = .didShowFavouritesFlow(favouritesOutput: favouritesOutput)
        self.loop()
    }

    func start() {
        self.loop()
    }

    private func loop() {
        state = next(state)
        switch state {
        case .willShowFavouritesFlow:
            goToFavouritesFlow()
            
        case .willShowEntertainmentDetail(let entertainment):
            showEntertainmentDetail(entertainment: entertainment)

        case .initial, .didShowFavouritesFlow:
            fatalError("Unexpected Case in App Coordinator")
        }
    }

    private func next(_ nextState: FavouritesCoordinatorState) -> FavouritesCoordinatorState {
        switch nextState {
        case .initial:
            return .willShowFavouritesFlow
            
        case .didShowFavouritesFlow(let favouritesOutput):
            switch favouritesOutput {
            case .goToEntertainmentDetail(entertainment: let entertainment):
                return .willShowEntertainmentDetail(entertainment: entertainment)
            }
            
        default:
            return nextState
        }
    }

    private func goToFavouritesFlow() {
        let vc = FavouritesBuilder {_ in}.build()
        navigator.pushViewController(vc, animated: true)
    }
    
    private func showEntertainmentDetail(entertainment: EntertainmentProtocol) {
        let vc = EntertainmentDetailBuilder(entertainment: entertainment) { _ in }.build()
        vc.modalPresentationStyle = .overFullScreen
        navigator.present(vc, animated: true)
    }
}

enum FavouritesCoordinatorState {
    case initial
    case didShowFavouritesFlow(favouritesOutput: FavouritesOutput)
    case willShowFavouritesFlow
    case willShowEntertainmentDetail(entertainment: EntertainmentProtocol)
}
