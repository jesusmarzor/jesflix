struct DtoEntertainmentVideos: Codable {
    let id: Int?
    let results: [DtoEntertainmentVideo]?
}

struct DtoEntertainmentVideo: Codable {
    let id, iso_639_1, iso_3166_1, name, key, site, type, publishedAt: String?
    let size: Int?
    let official: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso_639_1
        case iso_3166_1
        case name
        case key
        case site
        case type
        case publishedAt = "published_at"
        case size
        case official
    }
}

