import Foundation

class FavouritesInteractor: FavouritesInteractorProtocol {
    private var dataManager: FavouritesDataManagerProtocol

    init(dataManager: FavouritesDataManagerProtocol) {
        self.dataManager = dataManager
    }
}
