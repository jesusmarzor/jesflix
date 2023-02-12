protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func getUser() -> DtoUser
}
