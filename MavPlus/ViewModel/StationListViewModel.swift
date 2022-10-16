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
    
    private var disposables = Set<AnyCancellable>()
    
    init(){
        subscribe()
    }
    
    private func subscribe(){
        ApiRepository.shared.publisher
            .sink(
                receiveCompletion: {error in
                    print(error)
                }, receiveValue: { [weak self] value in
                    self?.stationList = value.stationList.map{station in
                        let location = ApiRepository.shared.stationLocationList.first{ loc in
                            return loc.code == station.code
                        }
                        var listItem = StationListItem(code: station.code ?? "", name: station.name ?? "Unknown")
                        if let lat = location?.lat, let lon = location?.lon {
                            listItem.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        }
                        return listItem
                    }
                })
            .store(in: &disposables)
    }
    
    func update() {
        self.stationList = ApiRepository.shared.stationList.map{station in
            return StationListItem(code: station.code ?? "", name: station.name ?? "Unknown")
        }
    }
}
