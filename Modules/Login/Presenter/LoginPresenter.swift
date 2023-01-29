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
        interactor.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.coordinatorOutput(.goToHomeFlow)

            case .failure(_):
                break
            }
        }
    }
}
