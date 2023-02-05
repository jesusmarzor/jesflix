class HomeInteractor: HomeInteractorProtocol {
    private var dataManager: HomeDataManagerProtocol

    init(dataManager: HomeDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getMoviesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoMovie>, JesflixError>) -> Void) {
        dataManager.getMoviesPagination(endPoint: endPoint) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSeriesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoSerie>, JesflixError>) -> Void) {
        dataManager.getSeriesPagination(endPoint: endPoint) { result in
            switch result {
            case .success(let series):
                completion(.success(series))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
