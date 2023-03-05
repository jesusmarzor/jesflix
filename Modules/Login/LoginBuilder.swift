import UIKit

class LoginBuilder {
    private var coordinatorOutput: (LoginOutput) -> Void

    init(coordinnatorOutput: @escaping (LoginOutput) -> Void) {
        self.coordinatorOutput = coordinnatorOutput
    }

    func build() -> UIViewController {
        let dataManager = LoginDataManager()
        let interactor = LoginInteractor(dataManager: dataManager)
        let presenter = LoginPresenter(interactor: interactor, coordinnatorOutput: coordinatorOutput)
        let view = LoginViewController(presenter: presenter)
        view.hidesBottomBarWhenPushed = true
        presenter.view = view
        return view
    }
}
