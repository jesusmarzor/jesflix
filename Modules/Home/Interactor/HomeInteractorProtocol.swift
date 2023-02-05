protocol HomeInteractorProtocol: AnyObject {
    func getMoviesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoMovie>, JesflixError>) -> Void)
    func getSeriesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoSerie>, JesflixError>) -> Void)
}
