import Foundation

class SearchInteractor: SearchInteractorProtocol {
    private var dataManager: SearchDataManagerProtocol

    init(dataManager: SearchDataManagerProtocol) {
        self.dataManager = dataManager
    }
}
