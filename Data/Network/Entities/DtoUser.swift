struct DtoUser: Codable {
    let id, name, email: String
    let photoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, photoUrl
    }
}
