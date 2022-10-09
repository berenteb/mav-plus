import Foundation

struct StationDetails {
    var name: String
    var isFavorite: Bool
    var departures: [Departure]
}

struct Departure {
    var trainCode: String
    var fromStationName: String
    var destinationStationName: String
    var trainName: String?
    var departureDate: Date?
}

protocol StationDetailsProtocol: RequestStatus, Updateable {
    var station: StationDetails? { get }
    func toggleFavorite() -> Void
}

class StationDetailsViewModel: StationDetailsProtocol, ObservableObject {
    @Published var station: StationDetails?
    @Published var isLoading: Bool
    @Published var isError: Bool
    private var storeRepository: StoreRepository
    private var code: String
    init(code: String, store: StoreRepository){
        self.code = code
        self.isLoading = true
        self.isError = false
        self.storeRepository = store
        update()
    }
    
    func update() {
        self.isLoading = true
        stationInfoRequest(stationNumberCode: code){station, error in
            self.isError = error != nil
            var departures: [Departure] = []
            if let stationTimetable = station?.stationSchedulerDetails {
                stationTimetable.departureScheduler?.forEach{dep in
                    departures.append(Departure(trainCode: dep.kind?.code ?? "", fromStationName: dep.startStation?.name ?? "Unknown", destinationStationName: dep.endStation?.name ?? "Unknown", trainName: dep.fullNameAndType, departureDate: DateFromIso(dep.actualOrEstimatedStart ?? "")))
                }
            }
            self.station = StationDetails(name: station?.stationSchedulerDetails?.station?.name ?? "Unknown", isFavorite: self.storeRepository.isFavoriteStation(code: self.code), departures: departures)
            self.isLoading = false
        }
    }
    
    func toggleFavorite() {
        if let isFavorite = self.station?.isFavorite {
            if isFavorite {
                storeRepository.deleteFavoriteStation(code: self.code)
            }else{
                storeRepository.saveFavoriteStation(code: self.code)
            }
        }
    }
}
