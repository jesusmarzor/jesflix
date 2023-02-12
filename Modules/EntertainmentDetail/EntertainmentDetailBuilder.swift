import UIKit

class EntertainmentDetailBuilder {
    private var coordinatorOutput: (EntertainmentDetailOutput) -> Void
    private var entertainment: EntertainmentProtocol
    
    init(entertainment: EntertainmentProtocol, coordinnatorOutput: @escaping (EntertainmentDetailOutput) -> Void) {
        self.entertainment = entertainment
        self.coordinatorOutput = coordinnatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = EntertainmentDetailDataManager()
        let interactor = EntertainmentDetailInteractor(dataManager: dataManager)
        let presenter = EntertainmentDetailPresenter(interactor: interactor, coordinnatorOutput: coordinatorOutput)
        let view = EntertainmentDetailViewController(entertainment: entertainment, presenter: presenter)
        presenter.view = view
        return view
    }
}
