import Foundation
import Combine

protocol HomeProtocol: Updateable {
    var favoriteStations: [FavoriteStationListItem] {get}
    var recentOffers: [RecentOfferListItem] {get}
    func deleteRecentOffer(id: UUID) -> Void
}

struct FavoriteStationListItem {
    var name: String
    var code: String
    var searchCount: Int32
}

struct RecentOfferListItem: Identifiable {
    var id: UUID
    var startStationName: String
    var startStationCode: String
    var endStationName: String
    var endStationCode: String
}

struct AlertListItem: Identifiable{
    var id: UUID
    var title: String
    var url: String
}

class HomeViewModel: HomeProtocol, ObservableObject {
    @Published var favoriteStations: [FavoriteStationListItem]
    @Published var recentOffers: [RecentOfferListItem]
    @Published var alerts: [AlertListItem]
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        self.favoriteStations = []
        self.recentOffers = []
        let items = RssRepository.shared.rssItemList.map{item in
            return AlertListItem(id: item.id, title: item.title, url: item.url)
        }
        self.alerts = items.count > 5 ? Array(items[0..<5]) : items
        update()
        subscribe()
    }
    
    func deleteRecentOffer(id: UUID){
        StoreRepository.shared.deleteRecentOffer(id: id)
        update()
    }
    
    func subscribe(){
        StoreRepository.shared.publisher.sink(receiveValue: {[unowned self] value in
            update()
        }).store(in: &disposables)
        
        RssRepository.shared.publisher.sink{fields in
            let items = fields.rssItemList.map{item in
                return AlertListItem(id: item.id, title: item.title, url: item.url)
            }
            self.alerts = items.count > 5 ? Array(items[0..<5]) : items
        }.store(in: &disposables)
    }
    
    func update(){
        updateRecentOffers()
        updateFavoriteStations()
    }
    
    func updateFavoriteStations(){
        self.favoriteStations = ApiRepository.shared.stationList
            .filter { station in
                guard let code = station.code else {return false}
                return StoreRepository.shared.isFavoriteStation(code: code)
            }.map{ fs in
                return FavoriteStationListItem(name: fs.name ?? "Unknown", code: fs.code!, searchCount: StoreRepository.shared.favoriteStationSearchCount(code: fs.code!))
            }
        
    }
    
    func updateRecentOffers(){
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
