import Foundation
import Combine

/// Station picker data model
struct FormStationListItem: Hashable, Comparable {
    var code: String
    var name: String
    var searchCount: Int32
    var isFavorite: Bool
    
    static func < (lhs: FormStationListItem, rhs: FormStationListItem) -> Bool {
        return (lhs.searchCount < rhs.searchCount)
    }
}

/// Form view model
class DirectionsFormViewModel: ObservableObject {
    /// Station list to search from
    @Published var stationList: [FormStationListItem]
    
    private var disposables = Set<AnyCancellable>()
    
    init(){
        let localStationList: [FormStationListItem] = ApiRepository.shared.stationList.map{station in
            let realCode: String = station.code ?? ""
            return FormStationListItem(code: realCode, name: station.name ?? "Unknown", searchCount: StoreRepository.shared.favoriteStationSearchCount(code: realCode), isFavorite: StoreRepository.shared.isFavoriteStation(code: realCode))
        }
        
        self.stationList = localStationList.sorted(by: >)
    }
    
    /// Adds 1 to the search count of both start and end stations and saves them
    /// - Parameters:
    ///     - start: Station of start in the form
    ///     - end: Station of end in the form
    private func incrementStationSearchCount(start: FormStationListItem, end: FormStationListItem) -> Void {
        StoreRepository.shared.saveFavoriteStation(code: start.code, searchCount: (start.searchCount + 1), isFavorite: start.isFavorite)
        StoreRepository.shared.saveFavoriteStation(code: end.code, searchCount: (end.searchCount + 1), isFavorite: end.isFavorite)
    }
    
    /// Creates offer from form data
    /// - Parameters:
    ///     - start: Station of start in the form
    ///     - end: Station of end in the form
    ///     - count: Count of passengers
    ///     - startDate: Date of travel
    public func createOfferViewModel(start: FormStationListItem, end: FormStationListItem, count: Int, startDate: Date) -> OfferViewModel {
        let result: OfferViewModel = OfferViewModel(start: start, end: end, passengerCount: count, startDate: startDate)
        self.incrementStationSearchCount(start: start, end: end)
        
        return result
    }
}
