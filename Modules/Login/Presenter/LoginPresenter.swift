import UIKit

class LoginPresenter {
    private var interactor: LoginInteractorProtocol
    weak var view: LoginViewProtocol?
    private var coordinatorOutput: (LoginOutput) -> Void
    private let coreData: CoreData

    init(interactor: LoginInteractorProtocol, coreData: CoreData = CoreData.sharedInstance, coordinnatorOutput: @escaping (LoginOutput) -> Void) {
        self.interactor = interactor
        self.coreData = coreData
        self.coordinatorOutput = coordinnatorOutput
    }
    
    private func loadMoviesPagination(with dispatchGroup: DispatchGroup, endPoint: EndPoint) {
        dispatchGroup.enter()
        interactor.getMoviesPagination(endPoint: endPoint) { [weak self] result in
            dispatchGroup.leave()
            switch result {
            case .success(_):
                break
                
            case .failure(let error):
                self?.view?.handleError(error)
            }
        }
    }
    
    private func loadSeriesPagination(with dispatchGroup: DispatchGroup, endPoint: EndPoint) {
        dispatchGroup.enter()
        interactor.getSeriesPagination(endPoint: endPoint) { [weak self] result in
            dispatchGroup.leave()
            switch result {
            case .success(_):
                break
                
            case .failure(let error):
                self?.view?.handleError(error)
            }
        }
    }
    
    private func loadEntertainments() {
        let dispatchGroup = DispatchGroup()
        loadMoviesPagination(with: dispatchGroup, endPoint: .commonPopular)
        loadMoviesPagination(with: dispatchGroup, endPoint: .commonTopRated)
        loadMoviesPagination(with: dispatchGroup, endPoint: .commonUpcoming)
        loadSeriesPagination(with: dispatchGroup, endPoint: .commonPopular)
        loadSeriesPagination(with: dispatchGroup, endPoint: .commonTopRated)
        dispatchGroup.notify(queue: .main) {
            self.view?.hideLoader()
            self.coordinatorOutput(.goToHomeFlow)
        }
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func loginUser(email: String, password: String) {
        view?.showLoader()
        interactor.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.loadEntertainments()

            case .failure(let error):
                self?.view?.hideLoader()
                self?.view?.handleError(error)
            }
        }
    }
    
    func loginUserWithBiometrics() {
        loadEntertainments()
    }
    
    func thereIsAnUserConected() -> String? {
        return coreData.getClient()?.email
    }
    
    func signOut() {
        coreData.setIsUsedBiometrics(with: false)
        coreData.signOut()
    }
    
    func setIsUsedBiometrics(with isUsedBiometrics: Bool) {
        coreData.setIsUsedBiometrics(with: isUsedBiometrics)
    }
    
    func isUsedBiometrics() -> Bool {
        return coreData.getIsUsedBiometrics() ?? false
    }
}
