import Foundation

struct StationListItem {
    var code: String
    var name: String
}

protocol StationListProtocol {
    var stationList: [StationListItem] {get}
}

class StationListViewModel: StationListProtocol, ObservableObject, Updateable {
    @Published var stationList: [StationListItem]
    
    init(){
        self.stationList = []
    }
    
    func update() {
        self.stationList = ApiRepository.shared.stationList.map{station in
            return StationListItem(code: station.code ?? "", name: station.name ?? "Unknown")
        }
    }
}
