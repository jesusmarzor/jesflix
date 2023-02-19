protocol EntertainmentDetailInteractorProtocol: AnyObject {
    func getEntertainmentVideo(endPoint: EndPoint, idEntertainment: Int, completion: @escaping (Result<DtoEntertainmentVideos, JesflixError>) -> Void)
}
