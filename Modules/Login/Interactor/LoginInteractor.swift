class LoginInteractor: LoginInteractorProtocol {
    
    private var dataManager: LoginDataManagerProtocol

    init(dataManager: LoginDataManagerProtocol) {
        self.dataManager = dataManager
    }
}
