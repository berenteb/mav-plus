import Foundation
import MapKit
import Combine

protocol MapProtocol: RequestStatus, Updateable {
    var locations: [LocationItem] {get}
}

struct LocationItem: Identifiable {
    let id: String
    let name: String
    let isStation: Bool
    let location: CLLocationCoordinate2D
    
    init(id: String, name: String, lat: Double, long: Double, isStation: Bool = false) {
        self.id = id
        self.name = name
        self.isStation = isStation
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

class MapViewModel: MapProtocol, ObservableObject {
    @Published var locations: [LocationItem]
    @Published var isError: Bool
    @Published var isLoading: Bool
    
    private var timer: Timer?
    private var disposables = Set<AnyCancellable>()
    
    init(){
        isError = false
        isLoading = true
        locations = [LocationItem]()
        subscribe()
        update()
        startTimer()
    }
    
    private func subscribe(){
        ApiRepository.shared.publisher
            .sink(
                receiveCompletion: {error in
                    print(error)
                }, receiveValue: { [weak self] value in
                    var localStationList: [LocationItem] = value.stationList.map{ station in
                        let stationLocation = ApiRepository.shared.stationLocationList.first{ loc in
                            return loc.code == station.code
                        }
                        if let lat = stationLocation?.lat, let lon = stationLocation?.lon {
                            var listItem = LocationItem(id: station.code ?? "", name: station.name ?? "Unknown", lat: lat, long: lon, isStation: true)
                            
                            return listItem
                        }
                        return LocationItem(id: "", name: "", lat: 0, long: 0)
                    }
                    
                    var stationIndex: Int = 0
                    while (stationIndex < localStationList.count) {
                        if (!localStationList[stationIndex].isStation) {
                            localStationList.remove(at: stationIndex)
                        } else {
                            stationIndex += 1
                        }
                    }
                    self?.locations.append(contentsOf: localStationList)
                })
            .store(in: &disposables)
    }
    
    private func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.updateTrains()
        }
    }
    
    private func updateTrains() -> Void {
        isLoading = true
        trainLocationRequest(){ locations, error in
            self.isError = error != nil
            if let trains = locations?.Vonatok {
                var localTrainList: [LocationItem] = [LocationItem]()
                trains.forEach{ loc in
                    if let id = loc.VonatID, let name = loc.Vonatnev {
                        let lat = loc.EGpsLat ?? loc.GpsLat
                        let lon = loc.EGpsLon ?? loc.GpsLon
                        if let lon = lon, let lat = lat {
                            localTrainList.append(LocationItem(id: id, name: name, lat: lat, long: lon))
                        }
                    }
                }
                
                var locationIndex: Int = 0
                while (locationIndex < self.locations.count) {
                    if let newTrainIndex: Int = localTrainList.firstIndex(where: { trainIterator in
                        return (self.locations[locationIndex].id == trainIterator.id)
                    }) {
                        self.locations[locationIndex] = localTrainList.remove(at: newTrainIndex)
                        locationIndex += 1
                        
                    } else if (!self.locations[locationIndex].isStation) {
                        self.locations.remove(at: locationIndex)
                    } else {
                        locationIndex += 1
                    }
                }
                
                self.locations.append(contentsOf: localTrainList)
            }
            self.isLoading = false
        }
    }
    
    func update() {
        self.updateTrains()
        
        var localStationList: [LocationItem] = ApiRepository.shared.stationList.map{ station in
            let stationLocation = ApiRepository.shared.stationLocationList.first{ loc in
                return loc.code == station.code
            }
            if let lat = stationLocation?.lat, let lon = stationLocation?.lon {
                var listItem = LocationItem(id: station.code ?? "", name: station.name ?? "Unknown", lat: lat, long: lon, isStation: true)
                
                return listItem
            }
            return LocationItem(id: "", name: "", lat: 0, long: 0)
        }
        
        var stationIndex: Int = 0
        while (stationIndex < localStationList.count) {
            if (!localStationList[stationIndex].isStation) {
                localStationList.remove(at: stationIndex)
            } else if let locationIndex: Int = self.locations.firstIndex(where: { iterator in
                return (localStationList[stationIndex].id == iterator.id)
            }) {
                self.locations[locationIndex] = localStationList.remove(at: stationIndex)
            } else {
                stationIndex += 1
            }
        }
        self.locations.append(contentsOf: localStationList)
    }
    
}
