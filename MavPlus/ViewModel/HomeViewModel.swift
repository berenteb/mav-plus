import Foundation

protocol HomeProtocol: Updateable {
    var favoriteStations: [FavoriteStationListItem] {get}
    var recentOffers: [RecentOfferListItem] {get}
    func deleteRecentOffer(id: UUID) -> Void
}

struct FavoriteStationListItem {
    var name: String
    var code: String
}

struct RecentOfferListItem {
    var id: UUID
    var startStationName: String
    var startStationCode: String
    var endStationName: String
    var endStationCode: String
}

class HomeViewModel: HomeProtocol, ObservableObject {
    @Published var favoriteStations: [FavoriteStationListItem]
    @Published var recentOffers: [RecentOfferListItem]
    
    init() {
        self.favoriteStations = []
        self.recentOffers = []
        update()
    }
    
    func deleteRecentOffer(id: UUID){
        StoreRepository.shared.deleteRecentOffer(id: id)
        update()
    }
    
    func update(){
        self.favoriteStations = ApiRepository.shared.stationList
            .filter { station in
                guard let code = station.code else {return false}
                return StoreRepository.shared.isFavoriteStation(code: code)
            }.map{ fs in
                return FavoriteStationListItem(name: fs.name ?? "Unknown", code: fs.code!)
            }
        self.recentOffers = []
        StoreRepository.shared.recentOffers.forEach{offer in
            let startName = ApiRepository.shared.stationList.first{station in station.code==offer.startCode}?.name ?? "Unknown"
            let endName = ApiRepository.shared.stationList.first{station in station.code==offer.endCode}?.name ?? "Unknown"
            if let startCode = offer.startCode, let endCode = offer.endCode, let id = offer.id {
                self.recentOffers.append(RecentOfferListItem(id: id, startStationName: startName, startStationCode: startCode, endStationName: endName, endStationCode: endCode))
            }
        }
    }
}
