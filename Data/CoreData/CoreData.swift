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
    
    func getClient() -> DtoUser? {
        return queryItem(entityName: CoreDataKey.user.rawValue, item: DtoUser.self)
    }
}

enum CoreDataKey: String {
    case user = "User"
    case jsonData = "jsonData"
}
