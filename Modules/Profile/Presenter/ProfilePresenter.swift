import UIKit

class ProfilePresenter {
    private var interactor: ProfileInteractorProtocol
    weak var view: ProfileViewProtocol?
    private var coordinatorOutput: (ProfileOutput) -> Void
    private let client: DtoUser
    private let coreData: CoreData

    init(coreData: CoreData = CoreData.sharedInstance, interactor: ProfileInteractorProtocol, coordinnatorOutput: @escaping (ProfileOutput) -> Void) {
        client = coreData.getClient()!
        self.coreData = coreData
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
    
    private func createTableViewModel() -> [ProfileTableViewModel] {
        return [
            ProfileTableViewModel(type: .header, icon: UIImage(systemName: "person.circle.fill")!, label: client.photoUrl),
            ProfileTableViewModel(type: .editProfile, icon: UIImage(systemName: "pencil.circle.fill")!, label: "Editar perfil"),
            ProfileTableViewModel(type: .changePassword, icon: UIImage(systemName: "person.circle.fill")!, label: "Cambiar contraseña"),
            ProfileTableViewModel(type: .logout, icon: UIImage(systemName: "restart.circle.fill")!, label: "Cerrar sesión")
        ]
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewDidLoad() {
        let model = createTableViewModel()
        view?.updateContent(with: model)
    }
    
    func logout() {
        coreData.signOut()
        coordinatorOutput(.logout)
    }
}
