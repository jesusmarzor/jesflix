import Foundation

class EntertainmentDetailPresenter {
    private var interactor: EntertainmentDetailInteractorProtocol
    weak var view: EntertainmentDetailViewProtocol?
    private var coordinatorOutput: (EntertainmentDetailOutput) -> Void

    init(interactor: EntertainmentDetailInteractorProtocol, coordinnatorOutput: @escaping (EntertainmentDetailOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
}

extension EntertainmentDetailPresenter: EntertainmentDetailPresenterProtocol {
}
