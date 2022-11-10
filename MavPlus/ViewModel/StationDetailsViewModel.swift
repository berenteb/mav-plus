import Foundation
import MapKit

struct StationDetails {
    var name: String
    var isFavorite: Bool
    var searchCount: Int32
    var departures: [Departure]
    var location: CLLocationCoordinate2D?
}

struct TrainPictogram{
    var foregroundColor: String
    var backgroundColor: String
    var name: String
}

struct Departure: Identifiable {
    var id: UUID
    var trainCode: String
    var fromStationName: String
    var destinationStationName: String
    var trainName: String?
    var trainPictogram: TrainPictogram?
    var departureDate: Date?
    var corrigatedDepartureDate: Date?
    var isDelayed: Bool
    init(trainCode: String, fromStationName: String, destinationStationName: String, trainName: String? = nil, departureDate: Date? = nil, corrigatedDepartureDate: Date? = nil, isDelayed: Bool) {
        self.id = UUID()
        self.trainCode = trainCode
        self.fromStationName = fromStationName
        self.destinationStationName = destinationStationName
        self.trainName = trainName
        self.departureDate = departureDate
        self.corrigatedDepartureDate = corrigatedDepartureDate
        self.isDelayed = isDelayed
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
                    
                    var departure = Departure(
                        trainCode: dep.kind?.code ?? "",
                        fromStationName: dep.startStation?.name ?? "Unknown",
                        destinationStationName: dep.endStation?.name ?? "Unknown",
                        trainName: dep.name,
                        departureDate: DateFromIso(dep.start ?? ""),
                        corrigatedDepartureDate: DateFromIso(dep.actualOrEstimatedStart ?? ""),
                        isDelayed: false
                    )
                    if let start = dep.start, let actual = dep.actualOrEstimatedStart{
                        departure.isDelayed = actual > start
                    }
                    if let signName = dep.viszonylatiJel?.jel, let fgColor = dep.viszonylatiJel?.fontSzinKod, let bgColor = dep.viszonylatiJel?.hatterSzinKod {
                        departure.trainPictogram = TrainPictogram(
                            foregroundColor: fgColor,
                            backgroundColor: bgColor,
                            name: signName
                        )
                    }else if let signName = dep.kind?.sortName, let fgColor = dep.kind?.foregroundColorCode, let bgColor = dep.kind?.backgroundColorCode {
                        departure.trainPictogram = TrainPictogram(
                            foregroundColor: fgColor,
                            backgroundColor: bgColor,
                            name: signName
                        )
                    }
                    return departure
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
            var station = StationDetails(name: station?.stationSchedulerDetails?.station?.name ?? "Unknown", isFavorite: StoreRepository.shared.isFavoriteStation(code: self.code), searchCount: StoreRepository.shared.favoriteStationSearchCount(code: self.code), departures: departures)
            if let lat = location?.lat, let lon = location?.lon {
                station.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            self.station = station
            self.isLoading = false
        }
    }
    
    func toggleFavorite() {
        self.station?.isFavorite.toggle()
        if let isFavorite = self.station?.isFavorite {
            StoreRepository.shared.saveFavoriteStation(code: self.code, searchCount: self.station?.searchCount ?? 0, isFavorite: isFavorite)
        }
    }
}
