protocol LoginDataManagerProtocol: AnyObject {
    func loginUser(email: String, password: String, completion: @escaping (Result<DtoUser, JesflixError>) -> Void)
}
