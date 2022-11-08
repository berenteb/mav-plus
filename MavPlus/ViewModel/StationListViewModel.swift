import Foundation
import MapKit
import Combine

struct StationListItem {
    var code: String
    var name: String
    var location: CLLocationCoordinate2D?
}

protocol StationListProtocol: Updateable, ObservableObject {
    var stationList: [StationListItem] {get}
}

class StationListViewModel: StationListProtocol {
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
            var listItem = StationListItem(code: station.code ?? "", name: station.name ?? "Unknown")
            if let lat = location?.lat, let lon = location?.lon {
                listItem.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            return listItem
        }
    }
}
