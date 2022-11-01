import Foundation
import MapKit
import Combine

protocol MapProtocol: RequestStatus, Updateable {
    var locations: [LocationItem] {get}
    var region: MKCoordinateRegion { get set }
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
    
    @Published var region: MKCoordinateRegion {
        didSet {
            self.filterForVisibleLocation()
        }
    }
    
    private var timer: Timer?
    private var disposables = Set<AnyCancellable>()
    private var allLocationsList: [LocationItem]
    
    init(){
        isError = false
        isLoading = true
        locations = []
        self.allLocationsList = [LocationItem]()
        
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 47.497854,
                                           longitude: 19.040170),
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        
        update()
    }
    
    public func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            self.updateTrains()
        }
    }
    
    public func stopTimer(){
        timer?.invalidate()
    }
    
    private func filterForVisibleLocation() -> Void {
        var outputLocationList: [LocationItem] = [LocationItem]()
        
        for locationIterator in self.allLocationsList {
            let locationLatitudeDegrees: CGFloat = cos( (self.region.center.latitude - locationIterator.location.latitude) * (.pi / 180.0) )
            let regionMaxLatitudeDegree: CGFloat = cos( (self.region.span.latitudeDelta / 2.0) * (.pi / 180.0) )
            let locationLongitudeDegrees: CGFloat = cos( (self.region.center.longitude - locationIterator.location.longitude) * (.pi / 180.0) )
            let regionMaxLongitudeDegree: CGFloat = cos( (self.region.span.longitudeDelta / 2.0) * (.pi / 180.0) )
            
            if (locationLatitudeDegrees > regionMaxLatitudeDegree && locationLongitudeDegrees > regionMaxLongitudeDegree) {
                // location is in region
                
                outputLocationList.append(locationIterator)
            }
        }
        
        DispatchQueue.main.async {
            self.locations = outputLocationList
        }
    }
    
    private func updateTrains() -> Void {
        isLoading = true
        ApiRepository.shared.getTrainLocations(){ locations, error in
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
                while (locationIndex < self.allLocationsList.count) {
                    if let newTrainIndex: Int = localTrainList.firstIndex(where: { trainIterator in
                        return (self.allLocationsList[locationIndex].id == trainIterator.id)
                    }) {
                        self.allLocationsList[locationIndex] = localTrainList.remove(at: newTrainIndex)
                        locationIndex += 1
                        
                    } else if (!self.allLocationsList[locationIndex].isStation) {
                        self.allLocationsList.remove(at: locationIndex)
                    } else {
                        locationIndex += 1
                    }
                }
                
                self.allLocationsList.append(contentsOf: localTrainList)
            }
            self.filterForVisibleLocation()
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
            } else if let locationIndex: Int = self.allLocationsList.firstIndex(where: { iterator in
                return (localStationList[stationIndex].id == iterator.id)
            }) {
                self.allLocationsList[locationIndex] = localStationList.remove(at: stationIndex)
            } else {
                stationIndex += 1
            }
        }
        self.allLocationsList.append(contentsOf: localStationList)
        self.filterForVisibleLocation()
    }
    
}
