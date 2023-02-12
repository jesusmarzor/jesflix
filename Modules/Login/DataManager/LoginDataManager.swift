import FirebaseAuth

class LoginDataManager: LoginDataManagerProtocol {
    private let serviceProxy = ServiceProxy.sharedInstance
    
    func loginUser(email: String, password: String, completion: @escaping (Result<DtoUser, JesflixError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result, error == nil {
                let user = DtoUser.init(
                    id: result.user.uid,
                    name: result.user.displayName ?? "",
                    email: result.user.email!,
                    photoUrl: result.user.photoURL?.absoluteString
                )
                completion(.success(user))
            } else {
                switch AuthErrorCode.Code(rawValue: error!._code) {
                case .wrongPassword:
                    completion(.failure(.wrongPassword))
                
                case .userNotFound:
                    completion(.failure(.userNotFound))
                    
                default:
                    completion(.failure(.common))
                }
            }
        }
    }
    
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
