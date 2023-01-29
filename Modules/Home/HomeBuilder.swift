import UIKit

class HomeBuilder {
    private var coordinatorOutput: (HomeOutput) -> Void
    
    init(coordinnatorOutput: @escaping (HomeOutput) -> Void) {
        self.coordinatorOutput = coordinnatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = HomeDataManager()
        let interactor = HomeInteractor(dataManager: dataManager)
        let presenter = HomePresenter(interactor: interactor, coordinnatorOutput: coordinatorOutput)
        let view = HomeViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
