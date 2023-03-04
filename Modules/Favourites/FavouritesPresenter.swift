import Foundation

class FavouritesPresenter {
    private var interactor: FavouritesInteractorProtocol
    weak var view: FavouritesViewProtocol?
    private var coordinatorOutput: (FavouritesOutput) -> Void

    init(interactor: FavouritesInteractorProtocol, coordinnatorOutput: @escaping (FavouritesOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
}
