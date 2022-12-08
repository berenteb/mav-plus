import Foundation
import Combine

/// Favorite stations
struct FavoriteStationListItem {
    var name: String
    var code: String
    var searchCount: Int32
}

/// Recent offers
struct RecentOfferListItem: Identifiable {
    var id: UUID
    var startStationName: String
    var startStationCode: String
    var endStationName: String
    var endStationCode: String
}

/// Alerts
struct AlertListItem: Identifiable{
    var id: UUID
    var title: String
    var url: String
}

/// Home view model with favorite stations, recent offers and alerts
class HomeViewModel: Updateable, ObservableObject {
    /// Favorite stations based on CoreData and StationList
    @Published var favoriteStations: [FavoriteStationListItem]
    /// Recent offers based on CoreData and StationList
    @Published var recentOffers: [RecentOfferListItem]
    /// Alerts based on RSS feed
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
    
    /// Deletes recent offer from storage
    func deleteRecentOffer(id: UUID){
        StoreRepository.shared.deleteRecentOffer(id: id)
        update()
    }
    
    /// Subscribes to async data
    func subscribe(){
        StoreRepository.shared.publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[unowned self] value in
                update()
            })
            .store(in: &disposables)
        
        RssRepository.shared.publisher
            .receive(on: DispatchQueue.main)
            .sink{fields in
                let items = fields.rssItemList.map{item in
                    return AlertListItem(id: item.id, title: item.title, url: item.url)
                }
                self.alerts = items.count > 5 ? Array(items[0..<5]) : items
            }
            .store(in: &disposables)
    }
    
    func update(){
        updateRecentOffers()
        updateFavoriteStations()
    }
    
    /// Updates favorite station list
    func updateFavoriteStations(){
        self.favoriteStations = ApiRepository.shared.stationList
            .filter { station in
                guard let code = station.code else {return false}
                return StoreRepository.shared.isFavoriteStation(code: code)
            }.map{ fs in
                return FavoriteStationListItem(name: fs.name ?? "Unknown", code: fs.code!, searchCount: StoreRepository.shared.favoriteStationSearchCount(code: fs.code!))
            }
        
    }
    
    /// Updates recent offers
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
