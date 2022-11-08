import Foundation
import Combine

struct FormStationListItem: Hashable, Comparable {
    var code: String
    var name: String
    var searchCount: Int32
    var isFavorite: Bool
    
    static func < (lhs: FormStationListItem, rhs: FormStationListItem) -> Bool {
        return (lhs.searchCount < rhs.searchCount)
    }
}

protocol DirectionsFormProtocol: ObservableObject {
    var stationList: [FormStationListItem] {get}
}

class DirectionsFormViewModel: DirectionsFormProtocol {
    @Published var stationList: [FormStationListItem]
    
    private var disposables = Set<AnyCancellable>()
    
    init(){
        let localStationList: [FormStationListItem] = ApiRepository.shared.stationList.map{station in
            let realCode: String = station.code ?? ""
            return FormStationListItem(code: realCode, name: station.name ?? "Unknown", searchCount: StoreRepository.shared.favoriteStationSearchCount(code: realCode), isFavorite: StoreRepository.shared.isFavoriteStation(code: realCode))
        }
        
        self.stationList = localStationList.sorted(by: >)
    }
    
    private func incrementStationSearchCount(start: FormStationListItem, end: FormStationListItem) -> Void {
        StoreRepository.shared.saveFavoriteStation(code: start.code, searchCount: (start.searchCount + 1), isFavorite: start.isFavorite)
        StoreRepository.shared.saveFavoriteStation(code: end.code, searchCount: (end.searchCount + 1), isFavorite: end.isFavorite)
    }
    
    public func createOfferViewModel(start: FormStationListItem, end: FormStationListItem, count: Int, startDate: Date) -> OfferViewModel {
        let result: OfferViewModel = OfferViewModel(start: start, end: end, passengerCount: count, startDate: startDate)
        self.incrementStationSearchCount(start: start, end: end)
        
        return result
    }
}
