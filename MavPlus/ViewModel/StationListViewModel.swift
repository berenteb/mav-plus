import Foundation
import MapKit
import Combine

struct StationListItem: Comparable {
    var code: String
    var name: String
    var searchCount: Int32
    var location: CLLocationCoordinate2D?
    
    static func < (lhs: StationListItem, rhs: StationListItem) -> Bool {
        return (lhs.searchCount < rhs.searchCount)
    }
    
    static func == (lhs: StationListItem, rhs: StationListItem) -> Bool {
        return ( (lhs.searchCount == rhs.searchCount) && (lhs.code == rhs.code) )
    }
}

class StationListViewModel: Updateable, ObservableObject {
    @Published var stationList: [StationListItem] = []
        
    init(){
        update()
    }
    
    func update() {
        self.stationList = ApiRepository.shared.stationList
            .filter{
                return !$0.isAlias
            }
            .map{station in
            let location = ApiRepository.shared.stationLocationList.first{ loc in
                return loc.code == station.code
            }
            var listItem = StationListItem(code: station.code ?? "", name: station.name ?? "Unknown", searchCount: StoreRepository.shared.favoriteStationSearchCount(code: station.code ?? ""))
            if let lat = location?.lat, let lon = location?.lon {
                listItem.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            return listItem
        }
    }
}
