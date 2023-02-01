class LoginInteractor {
    private var dataManager: LoginDataManagerProtocol
    private let coreData = CoreData.sharedInstance
    
    init(dataManager: LoginDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    private func saveUserCoreData(_ user: DtoUser) {
        coreData.saveUser(user)
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, JesflixError>) -> Void) {
        dataManager.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.saveUserCoreData(user)
                completion(.success(true))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
