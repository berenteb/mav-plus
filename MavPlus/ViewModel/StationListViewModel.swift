import Foundation

struct StationListItem {
    var code: String
    var name: String
}

protocol StationListProtocol {
    var stationList: [StationListItem] {get}
}

class StationListViewModel: StationListProtocol, ObservableObject {
    @Published var stationList: [StationListItem]
    private var apiRepository: ApiRepository
    
    init(api: ApiRepository){
        self.apiRepository = api
        self.stationList = []
        apiRepository.stationList.forEach{station in
            if let code = station.code, let name = station.name {
                self.stationList.append(StationListItem(code: code , name: name ))
            }
        }
    }
}
