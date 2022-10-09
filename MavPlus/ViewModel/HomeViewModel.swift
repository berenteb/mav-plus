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
    private var storeRepository: StoreRepository
    private var apiRepository: ApiRepository
    
    init(store: StoreRepository, api: ApiRepository) {
        self.storeRepository = store
        self.apiRepository = api
        self.favoriteStations = []
        self.recentOffers = []
        update()
    }
    
    func deleteRecentOffer(id: UUID){
        storeRepository.deleteRecentOffer(id: id)
        update()
    }
    
    func update(){
        self.favoriteStations = apiRepository.stationList
            .filter { station in
                guard let code = station.code else {return false}
                return storeRepository.isFavoriteStation(code: code)
            }.map{ fs in
                return FavoriteStationListItem(name: fs.name ?? "Unknown", code: fs.code!)
            }
        self.recentOffers = []
        storeRepository.recentOffers.forEach{offer in
            let startName = apiRepository.stationList.first{station in station.code==offer.startCode}?.name ?? "Unknown"
            let endName = apiRepository.stationList.first{station in station.code==offer.endCode}?.name ?? "Unknown"
            if let startCode = offer.startCode, let endCode = offer.endCode, let id = offer.id {
                self.recentOffers.append(RecentOfferListItem(id: id, startStationName: startName, startStationCode: startCode, endStationName: endName, endStationCode: endCode))
            }
        }
    }
}
