import Foundation

class EntertainmentDetailInteractor: EntertainmentDetailInteractorProtocol {
    private var dataManager: EntertainmentDetailDataManagerProtocol

    init(dataManager: EntertainmentDetailDataManagerProtocol) {
        self.dataManager = dataManager
    }
}
