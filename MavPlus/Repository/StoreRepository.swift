import Foundation
import Combine

protocol StoreProtocol {
    static var shared: any StoreProtocol {get}
    
    var favoriteStations: [FavoriteStation] {get}
    var recentOffers: [RecentOffer] {get}
    var controller: PersistenceController {get}
    
    func updateFavoriteStationList() -> Void
//    func deleteFavoriteStation(code: String) -> Void
    func saveFavoriteStation(code: String, searchCount: Int32, isFavorite: Bool) -> Void
    
    func updateRecentOfferList() -> Void
    func deleteRecentOffer(id: UUID) -> Void
    func saveRecentOffer(startCode: String, endCode: String) -> Void
    
    func favoriteStationSearchCount(code: String) -> Int32
    func isFavoriteStation(code: String) -> Bool
    
    var publisher: PassthroughSubject<StoreFields, Never> { get }
}

struct StoreFields {
    var favoriteStations: [FavoriteStation]
    var recentOffers: [RecentOffer]
}

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
