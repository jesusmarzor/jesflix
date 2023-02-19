class EntertainmentDetailPresenter {
    private var interactor: EntertainmentDetailInteractorProtocol
    weak var view: EntertainmentDetailViewProtocol?
    private var coordinatorOutput: (EntertainmentDetailOutput) -> Void

    init(interactor: EntertainmentDetailInteractorProtocol, coordinnatorOutput: @escaping (EntertainmentDetailOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
    
    private func getEntertainmentVideo(entertainment: EntertainmentProtocol) {
        let entertainmentEndPoint: EndPoint = (type(of: entertainment) == DtoMovie.self) ? EndPoint.movie : EndPoint.serie
        view?.showLoader()
        interactor.getEntertainmentVideo(endPoint: entertainmentEndPoint, idEntertainment: entertainment.id) { [weak self] result in
            self?.view?.hideLoader()
            switch result {
            case .success(let videos):
                let idVideo = videos.results?.first?.key ?? JesflixEnvironment.defaultVideoId
                self?.view?.updateYTPlayerVideo(with: idVideo)
                
            case .failure(let error):
                self?.view?.handleError(error)
            }
        }
    }
}

extension EntertainmentDetailPresenter: EntertainmentDetailPresenterProtocol {
    func viewDidLoad(entertainment: EntertainmentProtocol) {
        getEntertainmentVideo(entertainment: entertainment)
    }
}
