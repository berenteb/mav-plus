import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MavPlus")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getRecentOfferList() -> [RecentOffer] {
        do{
            let recentOffers = try container.viewContext.fetch(RecentOffer.fetchRequest())
            return recentOffers
        }catch{
            return []
        }
    }

    func deleteRecentOffer(id: UUID) {
        do{
            let request = RecentOffer.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", id.uuidString)
            let items = try container.viewContext.fetch(request)
            if(items.isEmpty) {return}
            container.viewContext.delete(items[0])
            try container.viewContext.save()
        }catch{
            return
        }
    }

    func saveRecentOffer(startCode: String, endCode: String) {
        let newRecentOffer = RecentOffer(context: container.viewContext)
        newRecentOffer.startCode = startCode
        newRecentOffer.endCode = endCode
        newRecentOffer.id = UUID()
        do{
            try container.viewContext.save()
        }catch{
            return
        }
    }
    
    func getFavoriteStationList() -> [FavoriteStation] {
        do{
            let favoriteStations = try container.viewContext.fetch(FavoriteStation.fetchRequest())
            return favoriteStations
        }catch{
            return []
        }
    }

    func deleteFavoriteStation(code: String) {
        do{
            let request = FavoriteStation.fetchRequest()
            request.predicate = NSPredicate(format: "code = %@", code)
            let items = try container.viewContext.fetch(request)
            if(items.isEmpty) {return}
            container.viewContext.delete(items[0])
            try container.viewContext.save()
        }catch{
            return
        }
    }

    func saveFavoriteStation(code: String) {
        let newFavorite = FavoriteStation(context: container.viewContext)
        newFavorite.code = code
        do{
            try container.viewContext.save()
        }catch{
            return
        }
    }
}
