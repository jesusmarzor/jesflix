class EntertainmentDetailDataManager: EntertainmentDetailDataManagerProtocol {
    private let serviceProxy = ServiceProxy.sharedInstance
    
    func getEntertainmentVideo(endPoint: EndPoint, idEntertainment: Int, completion: @escaping (Result<DtoEntertainmentVideos, JesflixError>) -> Void) {
        serviceProxy.getItem(url: endPoint.rawValue + String(idEntertainment) + EndPoint.commonVideos.rawValue, type: DtoEntertainmentVideos.self, parameters: [:]) { result in
            switch result {
            case .success(let videos):
                completion(.success(videos))
                
            case .failure(let error):
                completion(.failure(JesflixError.videosNotFound))
            }
        }
    }
}
