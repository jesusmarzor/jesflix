import Alamofire

class ServiceProxy: RequestInterceptor {
    static let sharedInstance: ServiceProxy = ServiceProxy()
    private let mainURL: String
    private let apiKey: String
    
    init() {
        self.mainURL = JesflixEnvironment.baseURL
        self.apiKey = JesflixEnvironment.apiKey
    }
    
    func getItem<T: Decodable>(url: String, type: T.Type, parameters: [String: Any]?, headers: HTTPHeaders? = nil, queue: DispatchQueue = .main, completion: @escaping (Result<T, JesflixError>) -> Void) {
        let url = "\(mainURL)\(url)"
        var params = parameters
        params?["api_key"] = apiKey
        params?["language"] = "es-ES"
        AF.request(url, method: .get, parameters: params, headers: headers, interceptor: self).validate().responseDecodable(of: T.self, queue: queue) { response in
            print("IN<---------------------------------------")
            if let HTTPresponse = response.response {
                // Debug
                print(HTTPresponse)
            } else {
                print(response)
            }
            print("IN<---------------------------------------")

            if let data = response.data {
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            switch response.result {
            case .success(let result):
                completion(.success(result))

            case .failure(_):
                completion(.failure(.common))
            }
        }
    }
}
