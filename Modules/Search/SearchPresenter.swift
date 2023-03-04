import Foundation

class SearchPresenter {
    private var interactor: SearchInteractorProtocol
    weak var view: SearchViewProtocol?
    private var coordinatorOutput: (SearchOutput) -> Void

    init(interactor: SearchInteractorProtocol, coordinnatorOutput: @escaping (SearchOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
}

extension SearchPresenter: SearchPresenterProtocol {
}
