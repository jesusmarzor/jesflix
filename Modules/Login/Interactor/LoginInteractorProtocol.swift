protocol LoginInteractorProtocol: AnyObject {
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, JesflixError>) -> Void)
}
