import Foundation
import Combine

struct FormStationListItem: Hashable {
    var code: String
    var name: String
}

protocol DirectionsFormProtocol: ObservableObject {
    var stationList: [FormStationListItem] {get}
}

class DirectionsFormViewModel: DirectionsFormProtocol {
    @Published var stationList: [FormStationListItem]
    
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
                        return FormStationListItem(code: station.code ?? "", name: station.name ?? "Unknown")
                    }
                })
            .store(in: &disposables)
    }
}
