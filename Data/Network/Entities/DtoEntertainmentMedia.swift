struct DtoEntertainmentSection {
    let title: String
    let type: EntertainmentsType
    let entertainments: [EntertainmentProtocol]
}

enum EntertainmentsType: Codable {
    case moviesPopular
    case seriesPopular
    case moviesUpcoming
    case seriesOnTheAir
    case seriesAiringToday
    case moviesTopRated
    case seriesTopRated
}
