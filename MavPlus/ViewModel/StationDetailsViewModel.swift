import Foundation
import MapKit

struct StationDetails {
    var name: String
    var isFavorite: Bool
    var departures: [Departure]
    var location: CLLocationCoordinate2D?
}

struct Departure: Identifiable {
    var id: UUID
    var trainCode: String
    var fromStationName: String
    var destinationStationName: String
    var trainName: String?
    var departureDate: Date?
    init(trainCode: String, fromStationName: String, destinationStationName: String, trainName: String? = nil, departureDate: Date? = nil) {
        self.id = UUID()
        self.trainCode = trainCode
        self.fromStationName = fromStationName
        self.destinationStationName = destinationStationName
        self.trainName = trainName
        self.departureDate = departureDate
    }
}

protocol StationDetailsProtocol: RequestStatus, Updateable {
    var station: StationDetails? { get }
    func toggleFavorite() -> Void
}

class StationDetailsViewModel: StationDetailsProtocol, ObservableObject {
    @Published var station: StationDetails?
    @Published var isLoading: Bool
    @Published var isError: Bool
    private var code: String
    
    init(code: String){
        self.code = code
        self.isLoading = true
        self.isError = false
    }
    
    func update() {
        self.isLoading = true
        ApiRepository.shared.getStationInfo(stationNumberCode: code){station, error in
            self.isError = error != nil
            var departures: [Departure] = []
            if let stationTimetable = station?.stationSchedulerDetails?.departureScheduler {
                departures = stationTimetable.map{dep in
                    return Departure(
                        trainCode: dep.kind?.code ?? "",
                        fromStationName: dep.startStation?.name ?? "Unknown",
                        destinationStationName: dep.endStation?.name ?? "Unknown",
                        trainName: dep.fullNameAndType,
                        departureDate: DateFromIso(dep.start ?? "")
                    )
                }.sorted{a,b in
                    if let aStart = a.departureDate, let bStart = b.departureDate{
                        return aStart < bStart
                    }else{
                        return false
                    }
                }
            }
            let location = ApiRepository.shared.stationLocationList.first{ loc in
                return loc.code == self.code
            }
            var station = StationDetails(name: station?.stationSchedulerDetails?.station?.name ?? "Unknown", isFavorite: StoreRepository.shared.isFavoriteStation(code: self.code), departures: departures)
            if let lat = location?.lat, let lon = location?.lon {
                station.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            self.station = station
            self.isLoading = false
        }
    }
    
    func toggleFavorite() {
        if let isFavorite = self.station?.isFavorite {
            if isFavorite {
                StoreRepository.shared.deleteFavoriteStation(code: self.code)
            }else{
                StoreRepository.shared.saveFavoriteStation(code: self.code)
            }
        }
        self.station?.isFavorite.toggle()
    }
}
