class HomePresenter {
    private var interactor: HomeInteractorProtocol
    weak var view: HomeViewProtocol?
    private var coordinatorOutput: (HomeOutput) -> Void
    private var moviesPopularPagination: DtoEntertainmentPagination<DtoMovie>?
    private var seriesPopularPagination: DtoEntertainmentPagination<DtoSerie>?
    private var moviesUpcomingPagination: DtoEntertainmentPagination<DtoMovie>?
    private var seriesLatestPagination: DtoEntertainmentPagination<DtoSerie>?
    
    init(interactor: HomeInteractorProtocol, coordinnatorOutput: @escaping (HomeOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
    }
    
    private func getMoviesPagination(endPoint: EndPoint, sectionTitle: String, sectionType: EntertainmentsType) {
        self.view?.showLoader()
        interactor.getMoviesPagination(endPoint: endPoint) { [weak self] result in
            self?.view?.hideLoader()
            switch result {
            case .success(let movies):
                let sectionMovies = DtoEntertainmentSection(
                    title: sectionTitle,
                    type: sectionType,
                    entertainments: movies.results
                )
                self?.view?.updateEntertainmentSections(with: sectionMovies)
                
            case .failure(let error):
                self?.view?.handleError(error)
            }
        }
    }
    
    private func getSeriesPagination(endPoint: EndPoint, sectionTitle: String, sectionType: EntertainmentsType) {
        self.view?.showLoader()
        interactor.getSeriesPagination(endPoint: endPoint) { [weak self] result in
            self?.view?.hideLoader()
            switch result {
            case .success(let series):
                let sectionSeries = DtoEntertainmentSection(
                    title: sectionTitle,
                    type: sectionType,
                    entertainments: series.results
                )
                self?.view?.updateEntertainmentSections(with: sectionSeries)
                
            case .failure(let error):
                self?.view?.handleError(error)
            }
        }
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        getMoviesPagination(endPoint: .commonPopular, sectionTitle: "Películas populares", sectionType: .moviesPopular)
        getMoviesPagination(endPoint: .commonTopRated, sectionTitle: "Películas mejores valoradas", sectionType: .moviesTopRated)
        getSeriesPagination(endPoint: .commonTopRated, sectionTitle: "Series populares", sectionType: .seriesPopular)
        getSeriesPagination(endPoint: .commonTopRated, sectionTitle: "Series mejores valoradas", sectionType: .seriesTopRated)
        getMoviesPagination(endPoint: .commonUpcoming, sectionTitle: "Próximas películas", sectionType: .moviesUpcoming)
    }
}
