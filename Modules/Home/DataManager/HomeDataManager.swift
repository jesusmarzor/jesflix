class HomeDataManager: HomeDataManagerProtocol {
    private let serviceProxy = ServiceProxy.sharedInstance
    
    func getMoviesPagination<Entertainment: Codable>(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<Entertainment>, JesflixError>) -> Void) {
        serviceProxy.getItem(url: EndPoint.movie.rawValue + endPoint.rawValue, type: DtoEntertainmentPagination<Entertainment>.self, parameters: [:]) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSeriesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoSerie>, JesflixError>) -> Void) {
        serviceProxy.getItem(url: EndPoint.serie.rawValue + endPoint.rawValue, type: DtoEntertainmentPagination<DtoSerie>.self, parameters: [:]) { result in
            switch result {
            case .success(let series):
                completion(.success(series))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
