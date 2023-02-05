struct DtoEntertainmentPagination<T: Codable>: Codable {
    let page, totalPages, totalResults: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
