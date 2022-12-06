import Foundation
import Combine

/// Store singleton protocol for storage access
protocol StoreProtocol {
    /// Singleton instance of the class
    static var shared: any StoreProtocol {get}
    
    /// Favorite stations without any additional data
    var favoriteStations: [FavoriteStation] {get}
    /// Recent offers without any additional data
    var recentOffers: [RecentOffer] {get}
    /// Persistence controller for CoreData
    var controller: PersistenceController {get}
    /// Retrieves every saved favorite station
    func updateFavoriteStationList() -> Void
//    func deleteFavoriteStation(code: String) -> Void
    /// Saves a station as favorite
    /// - Parameters:
    ///     - code: Station code
    ///     - searchCount: count of the offer searches for this station
    ///     - isFavorite: whether the station has been selected as favorite
    func saveFavoriteStation(code: String, searchCount: Int32, isFavorite: Bool) -> Void
    /// Retrieves every saved recent offer
    func updateRecentOfferList() -> Void
    /// Deletes a recent offer by ID
    /// - Parameters:
    ///     - id: id of the offer
    func deleteRecentOffer(id: UUID) -> Void
    /// Saves recent offer
    /// - Parameters:
    ///     - startCode: start station code
    ///     - endCode: end station code
    func saveRecentOffer(startCode: String, endCode: String) -> Void
    /// Retrieves station search count
    /// - Parameters:
    ///     - code: Station code
    func favoriteStationSearchCount(code: String) -> Int32
    /// Checks whether the station with the given code is saved as favorite
    /// - Parameters:
    ///     - code: Station code
    func isFavoriteStation(code: String) -> Bool
    /// Async publisher, which sends when the data is retrieved from the storage
    var publisher: PassthroughSubject<StoreFields, Never> { get }
}

/// Store fields main data type
struct StoreFields {
    var favoriteStations: [FavoriteStation]
    var recentOffers: [RecentOffer]
}

/// Store repository to load inital data and to proxy requests to CoreData
class StoreRepository: StoreProtocol{
    
    static var shared = StoreRepository() as (any StoreProtocol)
    // Idea: CurrentValueSubjects
    var favoriteStations: [FavoriteStation]
    var recentOffers: [RecentOffer]
    var controller: PersistenceController
    
    var publisher = PassthroughSubject<StoreFields, Never>()
    
    private init(){
        self.favoriteStations = []
        self.recentOffers = []
        self.controller = PersistenceController.shared
        updateFavoriteStationList()
        updateRecentOfferList()
    }
    
    func notify(){
        publisher.send(StoreFields(favoriteStations: favoriteStations, recentOffers: recentOffers))
    }
    
    func updateFavoriteStationList(){
        self.favoriteStations = controller.getFavoriteStationList()
        notify()
    }
    
//    func deleteFavoriteStation(code: String){
//        controller.deleteFavoriteStation(code: code)
//        updateFavoriteStationList()
//    }
    
    func saveFavoriteStation(code: String, searchCount: Int32 = 0, isFavorite: Bool = false){
        controller.saveFavoriteStation(code: code, searchCount: searchCount, isFavorite: isFavorite)
        updateFavoriteStationList()
    }
    
    func updateRecentOfferList(){
        self.recentOffers = controller.getRecentOfferList()
        notify()
    }
    
    func deleteRecentOffer(id: UUID){
        controller.deleteRecentOffer(id: id)
        updateRecentOfferList()
    }
    
    func saveRecentOffer(startCode: String, endCode: String){
        let sameOffer = recentOffers.first{item in
            return item.startCode == startCode && item.endCode == endCode
        }
        if sameOffer != nil {return}
        controller.saveRecentOffer(startCode: startCode, endCode: endCode)
        updateRecentOfferList()
    }
    
    func favoriteStationSearchCount(code: String) -> Int32 {
        for favoriteStation in favoriteStations {
            if (favoriteStation.code == code) {
                return favoriteStation.searchCount
            }
        }
        return 0
    }
    
    func isFavoriteStation(code: String) -> Bool {
        for favoriteStation in favoriteStations {
            if (favoriteStation.code == code && favoriteStation.isFavorite) {
                return true
            }
        }
        return false
    }
}
