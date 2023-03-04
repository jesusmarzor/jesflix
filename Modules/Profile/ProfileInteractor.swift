import Foundation

class ProfileInteractor: ProfileInteractorProtocol {
    private var dataManager: ProfileDataManagerProtocol

    init(dataManager: ProfileDataManagerProtocol) {
        self.dataManager = dataManager
    }
}
