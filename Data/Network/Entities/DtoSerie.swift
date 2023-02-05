struct DtoSerie: Codable, EntertainmentProtocol {
    var id: Int
    var title, overview: String
    var adult: Bool?
    var banner, poster: String?
    var genres: [DtoGenre]?
    var voteAverage, popularity: Float?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, adult, genres, popularity
        case title = "name"
        case banner = "backdrop_path"
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func imageURL() -> String {
        return JesflixEnvironment.imageBaseURL + (poster ?? "")
    }
}
