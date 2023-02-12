class LoginInteractor {
    private var dataManager: LoginDataManagerProtocol
    private let coreData = CoreData.sharedInstance
    
    init(dataManager: LoginDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    private func saveUserCoreData(_ user: DtoUser) {
        coreData.saveUser(user)
    }
    
    private func saveMoviesPaginationCoreData(endpoint: EndPoint, _ moviesPagination: DtoEntertainmentPagination<DtoMovie>) {
        coreData.saveMoviesPagination(endPoint: endpoint, moviesPagination)
    }
    
    private func saveSeriesPaginationCoreData(endpoint: EndPoint, _ seriesPagination: DtoEntertainmentPagination<DtoSerie>) {
        coreData.saveSeriesPagination(endPoint: endpoint, seriesPagination)
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
    
    func getMoviesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoMovie>, JesflixError>) -> Void) {
        dataManager.getMoviesPagination(endPoint: endPoint) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.saveMoviesPaginationCoreData(endpoint: endPoint, movies)
                completion(.success(movies))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSeriesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoSerie>, JesflixError>) -> Void) {
        dataManager.getSeriesPagination(endPoint: endPoint) { [weak self] result in
            switch result {
            case .success(let series):
                self?.saveSeriesPaginationCoreData(endpoint: endPoint, series)
                completion(.success(series))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
