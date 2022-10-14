import Foundation
import Combine

struct StationListItem {
    var code: String
    var name: String
}

protocol StationListProtocol: Updateable, ObservableObject {
    var stationList: [StationListItem] {get}
}

class StationListViewModel: StationListProtocol {
    @Published var stationList: [StationListItem]
    
    private var disposables = Set<AnyCancellable>()
    
    init(){
        self.stationList = []
        subscribe()
    }
    
    private func subscribe(){
        ApiRepository.shared.publisher
            .sink(
                receiveCompletion: {error in
                    print(error)
                }, receiveValue: { [unowned self] value in
                    self.stationList = value.stationList.map{station in
                        return StationListItem(code: station.code ?? "", name: station.name ?? "Unknown")
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
