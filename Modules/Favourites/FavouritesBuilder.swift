import UIKit

class FavouritesBuilder {
    private var coordinatorOutput: (FavouritesOutput) -> Void
    
    init(coordinnatorOutput: @escaping (FavouritesOutput) -> Void) {
        self.coordinatorOutput = coordinnatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = FavouritesDataManager()
        let interactor = FavouritesInteractor(dataManager: dataManager)
        let presenter = FavouritesPresenter(interactor: interactor, coordinnatorOutput: coordinatorOutput)
        let view = FavouritesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
