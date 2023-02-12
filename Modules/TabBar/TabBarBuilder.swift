import UIKit

class TabBarBuilder: Builder {
    private var coordinatorOutput: (TabBarOutput) -> Void
    
    init(coordinnatorOutput: @escaping (TabBarOutput) -> Void) {
        self.coordinatorOutput = coordinnatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = TabBarDataManager()
        let interactor = TabBarInteractor(dataManager: dataManager)
        let presenter = TabBarPresenter(interactor: interactor, coordinnatorOutput: coordinatorOutput)
        let view = TabBarViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
