class HomePresenter {
    private var interactor: HomeInteractorProtocol
    weak var view: HomeViewProtocol?
    private var coreData: CoreData
    private var coordinatorOutput: (HomeOutput) -> Void
    private var moviesPopularPagination: DtoEntertainmentPagination<DtoMovie>?
    private var seriesPopularPagination: DtoEntertainmentPagination<DtoSerie>?
    private var moviesUpcomingPagination: DtoEntertainmentPagination<DtoMovie>?
    private var seriesLatestPagination: DtoEntertainmentPagination<DtoSerie>?
    
    init(interactor: HomeInteractorProtocol, coreData: CoreData = CoreData.sharedInstance, coordinnatorOutput: @escaping (HomeOutput) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinnatorOutput
        self.coreData = coreData
    }
    
    private func getMoviesPagination(endPoint: EndPoint, sectionTitle: String, sectionType: EntertainmentsType) {
        let moviesPagination = coreData.getMoviesPagination(endPoint: endPoint)
        if let moviesPagination = moviesPagination {
            let sectionMovies = DtoEntertainmentSection(
                title: sectionTitle,
                type: sectionType,
                entertainments: moviesPagination.results
            )
            self.view?.updateEntertainmentSections(with: sectionMovies)
        }
    }
    
    private func getSeriesPagination(endPoint: EndPoint, sectionTitle: String, sectionType: EntertainmentsType) {
        let seriesPagination = coreData.getSeriesPagination(endPoint: endPoint)
        if let seriesPagination = seriesPagination {
            let sectionSeries = DtoEntertainmentSection(
                title: sectionTitle,
                type: sectionType,
                entertainments: seriesPagination.results
            )
            self.view?.updateEntertainmentSections(with: sectionSeries)
        }
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        getMoviesPagination(endPoint: .commonPopular, sectionTitle: "Películas populares", sectionType: .moviesPopular)
        getMoviesPagination(endPoint: .commonTopRated, sectionTitle: "Películas mejores valoradas", sectionType: .moviesTopRated)
        getSeriesPagination(endPoint: .commonPopular, sectionTitle: "Series populares", sectionType: .seriesPopular)
        getSeriesPagination(endPoint: .commonTopRated, sectionTitle: "Series mejores valoradas", sectionType: .seriesTopRated)
        getMoviesPagination(endPoint: .commonUpcoming, sectionTitle: "Próximas películas", sectionType: .moviesUpcoming)
    }
    
    func getUser() -> DtoUser {
        return coreData.getClient()!
    }
}
