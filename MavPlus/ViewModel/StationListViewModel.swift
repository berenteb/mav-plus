import Foundation

struct StationListItem {
    var code: String
    var name: String
}

protocol StationListProtocol: Updateable, ObservableObject {
    var stationList: [StationListItem] {get}
}

class StationListViewModel: StationListProtocol {
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
