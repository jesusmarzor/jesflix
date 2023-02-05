struct DtoMovie: Codable, EntertainmentProtocol {
    var id: Int
    var title, overview: String
    var adult: Bool?
    var banner, poster: String?
    var genres: [DtoGenre]?
    var voteAverage, popularity: Float?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult, genres, popularity
        case banner = "backdrop_path"
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func imageURL() -> String {
        return JesflixEnvironment.imageBaseURL + (poster ?? "")
    }
}

protocol EntertainmentProtocol {
    var id: Int { get }
    var title: String { get }
    var overview: String { get }
    var adult: Bool? { get }
    var banner: String? { get }
    var poster: String? { get }
    var genres: [DtoGenre]? { get }
    var voteAverage: Float? { get }
    var popularity: Float? { get }
    var voteCount: Int? { get }
    
    func imageURL() -> String
}
