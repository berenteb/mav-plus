import Foundation
import MapKit
import Combine

protocol MapProtocol: RequestStatus, Updateable {
    var locations: [LocationItem] {get}
    var region: MKCoordinateRegion { get set }
}

struct LocationItem: Identifiable {
    private let realId: String
    var id: String {
        get {
            if (!self.isStation) {
                if let cutIndex: String.Index = self.realId.firstIndex(of: "_") {
                    let result: String = self.realId.prefix(upTo: cutIndex).description
                    return result
                }
            }
            return self.realId
        }
    }
    let name: String
    let isStation: Bool
    let location: CLLocationCoordinate2D
    
    init(id: String, name: String, lat: Double, long: Double, isStation: Bool = false) {
        self.realId = id
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
    
    @Published var showStations: Bool {
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
        self.showStations = true
        
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
            if (self.showStations || !locationIterator.isStation) {
                let locationLatitudeDegrees: CGFloat = cos( (self.region.center.latitude - locationIterator.location.latitude) * (.pi / 180.0) )
                let regionMaxLatitudeDegree: CGFloat = cos( (self.region.span.latitudeDelta / 2.0) * (.pi / 180.0) )
                let locationLongitudeDegrees: CGFloat = cos( (self.region.center.longitude - locationIterator.location.longitude) * (.pi / 180.0) )
                let regionMaxLongitudeDegree: CGFloat = cos( (self.region.span.longitudeDelta / 2.0) * (.pi / 180.0) )
                
                if (locationLatitudeDegrees > regionMaxLatitudeDegree && locationLongitudeDegrees > regionMaxLongitudeDegree) {
                    // location is in region
                    
                    var isCovered: Bool = false
                    for validLocationIterator in outputLocationList {
                        let minIconSizeFactor: Double = 20.0
                        
                        let fromRegionLocation: CLLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
                        let toRegionLocation: CLLocation = CLLocation(latitude: (region.center.latitude + (region.span.latitudeDelta / minIconSizeFactor)), longitude: (region.center.longitude + (region.span.longitudeDelta / minIconSizeFactor)) )
                        let regionDeltaDistance: CLLocationDistance = toRegionLocation.distance(from: fromRegionLocation)
                        
                        let fromLocation: CLLocation = CLLocation(latitude: validLocationIterator.location.latitude, longitude: validLocationIterator.location.longitude)
                        let toLocation: CLLocation = CLLocation(latitude: locationIterator.location.latitude, longitude: locationIterator.location.longitude)
                        let deltaDistance: CLLocationDistance = toLocation.distance(from: fromLocation)
                        
                        if (deltaDistance < regionDeltaDistance) {
                            isCovered = true
                            break
                        }
                    }
                    
                    if (!isCovered) {
                        outputLocationList.append(locationIterator)
                    }
                }
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
                
                var filteredLocationList: [LocationItem] = self.allLocationsList.filter({ locationIterator in
                    let isNotContained: Bool = !localTrainList.contains(where: { containIterator in
                        return (containIterator.id == locationIterator.id)
                    })
                    return (isNotContained && locationIterator.isStation)
                })
                
                filteredLocationList.append(contentsOf: localTrainList)
                
                self.allLocationsList = filteredLocationList
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
        
        var filteredLocationList: [LocationItem] = localStationList.filter({ stationIterator in
            if let oldIndex: Int = self.allLocationsList.firstIndex(where: { locationIterator in
                return (locationIterator.id == stationIterator.id)
            }) {
                self.allLocationsList.remove(at: oldIndex)
            }
            
            return stationIterator.isStation
        })
        
        self.allLocationsList.append(contentsOf: filteredLocationList)
        self.filterForVisibleLocation()
    }
    
}
