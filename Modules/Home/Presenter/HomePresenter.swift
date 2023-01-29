class HomePresenter {
    private var interactor: HomeInteractorProtocol
    weak var view: HomeViewProtocol?
    private var coordinatorOutput: (HomeOutput) -> Void

    init(interactor: HomeInteractorProtocol, coordinnatorOutput: @escaping (HomeOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
}

extension HomePresenter: HomePresenterProtocol {
}
