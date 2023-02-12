protocol LoginInteractorProtocol: AnyObject {
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, JesflixError>) -> Void)
    func getMoviesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoMovie>, JesflixError>) -> Void)
    func getSeriesPagination(endPoint: EndPoint, completion: @escaping (Result<DtoEntertainmentPagination<DtoSerie>, JesflixError>) -> Void)
}
