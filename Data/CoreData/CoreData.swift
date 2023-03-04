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
    
    private func putItem<T: Codable>(_ entityName: String, common: T, coreDataKey: CoreDataKey) {
        delete(entityName: entityName)
        let context = persistentContainer.viewContext
        let clientConfigQueryResult = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        let value: Any = (coreDataKey == .jsonData) ? try! JSONEncoder().encode(common) : common
        clientConfigQueryResult.setValue(value, forKey: coreDataKey.rawValue)
        do {
            try context.save()
        } catch {
            print("Core Data Error put item: \(error)")
        }
    }
    
    private func queryItem<T: Decodable>(entityName: String, item: T.Type, coreDataKey: CoreDataKey) -> T? {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false

        do {
            if coreDataKey == .jsonData {
                guard let result = try context.fetch(request).first as? NSManagedObject,
                      let jsonData = result.value(forKey: coreDataKey.rawValue) as? Data else { return nil }

                return try JSONDecoder().decode(T.self, from: jsonData)
            }
            guard let result = try context.fetch(request).first as? NSManagedObject,
                  let value = result.value(forKey: coreDataKey.rawValue) as? T else { return nil }

            return value
        } catch {
            return nil
        }
    }
    
    func saveUser<T: Codable>(_ user: T) {
        putItem(CoreDataKey.user.rawValue, common: user, coreDataKey: .jsonData)
    }
    
    func saveMoviesPagination(endPoint: EndPoint, _ moviesPagination: DtoEntertainmentPagination<DtoMovie>) {
        switch endPoint {
        case .commonPopular:
            putItem(CoreDataKey.popularMoviesPagination.rawValue, common: moviesPagination, coreDataKey: .jsonData)
            
        case .commonTopRated:
            putItem(CoreDataKey.topRatedMoviesPagination.rawValue, common: moviesPagination, coreDataKey: .jsonData)
            
        case .commonUpcoming:
            putItem(CoreDataKey.upcomingMoviesPagination.rawValue, common: moviesPagination, coreDataKey: .jsonData)
            
        default:
            break
        }
    }
    
    func saveSeriesPagination(endPoint: EndPoint, _ seriesPagination: DtoEntertainmentPagination<DtoSerie>) {
        switch endPoint {
        case .commonPopular:
            putItem(CoreDataKey.popularSeriesPagination.rawValue, common: seriesPagination, coreDataKey: .jsonData)
            
        case .commonTopRated:
            putItem(CoreDataKey.topRatedSeriesPagination.rawValue, common: seriesPagination, coreDataKey: .jsonData)
            
        default:
            break
        }
    }
    
    func getClient() -> DtoUser? {
        return queryItem(entityName: CoreDataKey.user.rawValue, item: DtoUser.self, coreDataKey: .jsonData)
    }
    
    func getMoviesPagination(endPoint: EndPoint) -> DtoEntertainmentPagination<DtoMovie>? {
        switch endPoint {
        case .commonPopular:
            return queryItem(entityName: CoreDataKey.popularMoviesPagination.rawValue, item: DtoEntertainmentPagination<DtoMovie>.self, coreDataKey: .jsonData)
        
        case .commonTopRated:
            return queryItem(entityName: CoreDataKey.topRatedMoviesPagination.rawValue, item: DtoEntertainmentPagination<DtoMovie>.self, coreDataKey: .jsonData)
            
        case .commonUpcoming:
            return queryItem(entityName: CoreDataKey.upcomingMoviesPagination.rawValue, item: DtoEntertainmentPagination<DtoMovie>.self, coreDataKey: .jsonData)
            
        default:
            return nil
        }
    }
    
    func getSeriesPagination(endPoint: EndPoint) -> DtoEntertainmentPagination<DtoSerie>? {
        switch endPoint {
        case .commonPopular:
            return queryItem(entityName: CoreDataKey.popularSeriesPagination.rawValue, item: DtoEntertainmentPagination<DtoSerie>.self, coreDataKey: .jsonData)
            
        case .commonTopRated:
            return queryItem(entityName: CoreDataKey.topRatedSeriesPagination.rawValue, item: DtoEntertainmentPagination<DtoSerie>.self, coreDataKey: .jsonData)
            
        default:
            return nil
        }
    }
    
    func signOut() {
        delete(entityName: CoreDataKey.user.rawValue)
    }
    
    func getIsUsedBiometrics() -> Bool? {
        return queryItem(entityName: CoreDataKey.biometrics.rawValue, item: Bool.self, coreDataKey: .isUsedBiometrics)
    }
    
    func setIsUsedBiometrics(with isUsedBiometrics: Bool) {
        putItem(CoreDataKey.biometrics.rawValue, common: isUsedBiometrics, coreDataKey: .isUsedBiometrics)
    }
}

enum CoreDataKey: String {
    case user = "User"
    case popularMoviesPagination = "PopularMoviesPagination"
    case upcomingMoviesPagination = "UpcomingMoviesPagination"
    case topRatedMoviesPagination = "TopRatedMoviesPagination"
    case popularSeriesPagination = "PopularSeriesPagination"
    case topRatedSeriesPagination = "TopRatedSeriesPagination"
    case biometrics = "Biometrics"
    case isUsedBiometrics = "isUsedBiometrics"
    case jsonData = "jsonData"
}
