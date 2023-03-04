import UIKit

class SearchBuilder {
    private var coordinatorOutput: (SearchOutput) -> Void
    
    init(coordinnatorOutput: @escaping (SearchOutput) -> Void) {
        self.coordinatorOutput = coordinnatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = SearchDataManager()
        let interactor = SearchInteractor(dataManager: dataManager)
        let presenter = SearchPresenter(interactor: interactor, coordinnatorOutput: coordinatorOutput)
        let view = SearchViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
