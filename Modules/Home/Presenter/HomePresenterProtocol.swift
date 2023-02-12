protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func getUser() -> DtoUser
    func goToEntertainmentDetail(entertainment: EntertainmentProtocol)
}
