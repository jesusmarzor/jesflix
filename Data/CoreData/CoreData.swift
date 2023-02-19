import CoreData

class CoreData {
    static let sharedInstance: CoreData = {
        let coreData = CoreData()
        return coreData
    }()
    private let persistentContainer: NSPersistentContainer
    private let persistentContainerName: String = "JesflixCoreData"
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: persistentContainerName)
        setupDatabase()
    }
    
    private func setupDatabase() {
        persistentContainer.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
        }
    }
    
    private func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    private func putItem<T: Codable>(_ entityName: String, common: T) {
        delete(entityName: entityName)
        let jsonData = try! JSONEncoder().encode(common)

        let context = persistentContainer.viewContext
        let clientConfigQueryResult = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        clientConfigQueryResult.setValue(jsonData, forKey: CoreDataKey.jsonData.rawValue)
        do {
            try context.save()
        } catch {
            print("Core Data Error put item: \(error)")
        }
    }
    
    private func queryItem<T: Decodable>(entityName: String, item: T.Type) -> T? {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false

        do {
            guard let result = try context.fetch(request).first as? NSManagedObject,
                  let jsonData = result.value(forKey: CoreDataKey.jsonData.rawValue) as? Data else { return nil }

            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    func saveUser<T: Codable>(_ user: T) {
        putItem(CoreDataKey.user.rawValue, common: user)
    }
    
    func saveMoviesPagination(endPoint: EndPoint, _ moviesPagination: DtoEntertainmentPagination<DtoMovie>) {
        switch endPoint {
        case .commonPopular:
            putItem(CoreDataKey.popularMoviesPagination.rawValue, common: moviesPagination)
            
        case .commonTopRated:
            putItem(CoreDataKey.topRatedMoviesPagination.rawValue, common: moviesPagination)
            
        case .commonUpcoming:
            putItem(CoreDataKey.upcomingMoviesPagination.rawValue, common: moviesPagination)
            
        default:
            break
        }
    }
    
    func saveSeriesPagination(endPoint: EndPoint, _ seriesPagination: DtoEntertainmentPagination<DtoSerie>) {
        switch endPoint {
        case .commonPopular:
            putItem(CoreDataKey.popularSeriesPagination.rawValue, common: seriesPagination)
            
        case .commonTopRated:
            putItem(CoreDataKey.topRatedSeriesPagination.rawValue, common: seriesPagination)
            
        default:
            break
        }
    }
    
    func getClient() -> DtoUser? {
        return queryItem(entityName: CoreDataKey.user.rawValue, item: DtoUser.self)
    }
    
    func getMoviesPagination(endPoint: EndPoint) -> DtoEntertainmentPagination<DtoMovie>? {
        switch endPoint {
        case .commonPopular:
            return queryItem(entityName: CoreDataKey.popularMoviesPagination.rawValue, item: DtoEntertainmentPagination<DtoMovie>.self)
        
        case .commonTopRated:
            return queryItem(entityName: CoreDataKey.topRatedMoviesPagination.rawValue, item: DtoEntertainmentPagination<DtoMovie>.self)
            
        case .commonUpcoming:
            return queryItem(entityName: CoreDataKey.upcomingMoviesPagination.rawValue, item: DtoEntertainmentPagination<DtoMovie>.self)
            
        default:
            return nil
        }
    }
    
    func getSeriesPagination(endPoint: EndPoint) -> DtoEntertainmentPagination<DtoSerie>? {
        switch endPoint {
        case .commonPopular:
            return queryItem(entityName: CoreDataKey.popularSeriesPagination.rawValue, item: DtoEntertainmentPagination<DtoSerie>.self)
            
        case .commonTopRated:
            return queryItem(entityName: CoreDataKey.topRatedSeriesPagination.rawValue, item: DtoEntertainmentPagination<DtoSerie>.self)
            
        default:
            return nil
        }
    }
    
    func signOut() {
        delete(entityName: CoreDataKey.user.rawValue)
    }
}

enum CoreDataKey: String {
    case user = "User"
    case popularMoviesPagination = "PopularMoviesPagination"
    case upcomingMoviesPagination = "UpcomingMoviesPagination"
    case topRatedMoviesPagination = "TopRatedMoviesPagination"
    case popularSeriesPagination = "PopularSeriesPagination"
    case topRatedSeriesPagination = "TopRatedSeriesPagination"
    case jsonData = "jsonData"
}
