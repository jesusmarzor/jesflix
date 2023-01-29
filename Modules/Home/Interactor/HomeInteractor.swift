class HomeInteractor: HomeInteractorProtocol {
    private var dataManager: HomeDataManagerProtocol

    init(dataManager: HomeDataManagerProtocol) {
        self.dataManager = dataManager
    }
}
