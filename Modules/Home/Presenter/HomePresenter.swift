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
        getMoviesPagination(endPoint: .commonPopular, sectionTitle: String.getLabelForKey("common_popular_movies"), sectionType: .moviesPopular)
        getMoviesPagination(endPoint: .commonTopRated, sectionTitle: String.getLabelForKey("common_top_rated_movies"), sectionType: .moviesTopRated)
        getSeriesPagination(endPoint: .commonPopular, sectionTitle: String.getLabelForKey("common_popular_series"), sectionType: .seriesPopular)
        getSeriesPagination(endPoint: .commonTopRated, sectionTitle: String.getLabelForKey("common_top_rated_series"), sectionType: .seriesTopRated)
        getMoviesPagination(endPoint: .commonUpcoming, sectionTitle: String.getLabelForKey("common_upcoming_movies"), sectionType: .moviesUpcoming)
    }
    
    func getUser() -> DtoUser {
        return coreData.getClient()!
    }
    
    func goToEntertainmentDetail(entertainment: EntertainmentProtocol) {
        coordinatorOutput(.goToEntertainmentDetail(entertainment: entertainment))
    }
}
