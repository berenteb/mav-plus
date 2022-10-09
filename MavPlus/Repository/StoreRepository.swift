import Foundation

class StoreRepository: ObservableObject{
    @Published var favoriteStations: [FavoriteStation]
    @Published var recentOffers: [RecentOffer]
    var controller: PersistenceController
    
    init(controller: PersistenceController){
        self.favoriteStations = []
        self.recentOffers = []
        self.controller = controller
        updateFavoriteStationList()
        updateRecentOfferList()
    }
    
    func updateFavoriteStationList(){
        self.favoriteStations = controller.getFavoriteStationList()
    }
    
    func deleteFavoriteStation(code: String){
        controller.deleteFavoriteStation(code: code)
        updateFavoriteStationList()
    }
    
    func saveFavoriteStation(code: String){
        controller.saveFavoriteStation(code: code)
        updateFavoriteStationList()
    }
    
    func updateRecentOfferList(){
        self.recentOffers = controller.getRecentOfferList()
    }
    
    func deleteRecentOffer(id: UUID){
        controller.deleteRecentOffer(id: id)
        updateRecentOfferList()
    }
    
    func saveRecentOffer(startCode: String, endCode: String){
        controller.saveRecentOffer(startCode: startCode, endCode: endCode)
        updateRecentOfferList()
    }
    
    func isFavoriteStation(code: String) -> Bool {
        for favoriteStation in favoriteStations {
            if favoriteStation.code == code {
                return true
            }
        }
        return false
    }
}
