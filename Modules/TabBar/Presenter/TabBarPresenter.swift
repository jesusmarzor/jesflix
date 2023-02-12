import Foundation

class TabBarPresenter {
    private var interactor: TabBarInteractorProtocol
    weak var view: TabBarViewProtocol?
    private var coordinatorOutput: (LoginOutput) -> Void

    init(interactor: TabBarInteractorProtocol, coordinnatorOutput: @escaping (LoginOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
}
