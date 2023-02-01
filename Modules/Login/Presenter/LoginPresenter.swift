class LoginPresenter {
    private var interactor: LoginInteractorProtocol
    private let coreData: CoreData = CoreData.sharedInstance
    weak var view: LoginViewProtocol?
    private var coordinatorOutput: (LoginOutput) -> Void

    init(interactor: LoginInteractorProtocol, coordinnatorOutput: @escaping (LoginOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func loginUser(email: String, password: String) {
        view?.showLoader()
        interactor.loginUser(email: email, password: password) { [weak self] result in
            self?.view?.hideLoader()
            switch result {
            case .success(_):
                self?.coordinatorOutput(.goToHomeFlow)

            case .failure(let error):
                self?.view?.handleError(error)
            }
        }
    }
}
