class EntertainmentDetailInteractor: EntertainmentDetailInteractorProtocol {
    private var dataManager: EntertainmentDetailDataManagerProtocol

    init(dataManager: EntertainmentDetailDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getEntertainmentVideo(endPoint: EndPoint, idEntertainment: Int, completion: @escaping (Result<DtoEntertainmentVideos, JesflixError>) -> Void) {
        dataManager.getEntertainmentVideo(endPoint: endPoint, idEntertainment: idEntertainment) { result in
            switch result {
            case .success(let videos):
                completion(.success(videos))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
