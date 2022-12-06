import Foundation
import MapKit
import Combine

class LocationItem: NSObject, MKAnnotation, Identifiable {
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
    let name: String?
    let isStation: Bool
    dynamic var coordinate: CLLocationCoordinate2D
    
    init(id: String, name: String?, lat: Double, long: Double, isStation: Bool = false) {
        self.realId = id
        self.name = name
        self.isStation = isStation
        self.coordinate = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

class MapViewModel: Updateable, RequestStatus, ObservableObject {
    @Published var locations: [LocationItem]
    private var stations: [LocationItem]
    @Published var allLocationsList: [LocationItem]
    
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
    @Published var showTrains: Bool {
        didSet {
            self.filterForVisibleLocation()
        }
    }
    
    @Published var locationNavStack: [LocationItem]
    @Published var uiKitMap: MKMapView?
    
    private var timer: Timer?
    private var disposables = Set<AnyCancellable>()
    
    init(){
        isError = false
        isLoading = true
        locations = []
        self.allLocationsList = [LocationItem]()
        self.stations = [LocationItem]()
        self.showStations = true
        self.showTrains = true
        self.locationNavStack = [LocationItem]()
        self.uiKitMap = nil
        
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 47.497854,
                                           longitude: 19.040170),
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        
        self.update()
    }
    
    public func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            self.update()
        }
    }
    
    public func stopTimer(){
        timer?.invalidate()
    }
    
    private func filterForVisibleLocation() -> Void {
        DispatchQueue.main.async {
            self.locations.removeAll()
            self.locations.append(contentsOf: self.allLocationsList.filter{item in
                return item.isStation && self.showStations || !item.isStation && self.showTrains
            })
            
            if let realMap: MKMapView = self.uiKitMap {
                realMap.setNeedsDisplay()
            }
        }
    }
    
    func update() {
        isLoading = true
        self.updateStations()
        ApiRepository.shared.getTrainLocations(){ locations, error in
            self.isError = error != nil
            if let trains = locations?.Vonatok {
                var localTrainList: [LocationItem] = [LocationItem]()
                trains.forEach{ loc in
                    if let id = loc.VonatID {
                        let lat = loc.EGpsLat ?? loc.GpsLat
                        let lon = loc.EGpsLon ?? loc.GpsLon
                        if let lon = lon, let lat = lat {
                            localTrainList.append(LocationItem(id: id, name: loc.Vonatnev, lat: lat, long: lon))
                        }
                    }
                }
                
                self.allLocationsList.removeAll()
                self.allLocationsList.append(contentsOf: self.stations)
                self.allLocationsList.append(contentsOf: localTrainList)
                self.filterForVisibleLocation()
            }
        }
    }
    
    func updateStations(){
        if !stations.isEmpty {return}
        ApiRepository.shared.stationList.forEach{ station in
            let stationLocation = ApiRepository.shared.stationLocationList.first{ loc in
                return loc.code == station.code
            }
            if let lat = stationLocation?.lat, let lon = stationLocation?.lon {
                let listItem = LocationItem(id: station.code ?? "", name: station.name ?? "Unknown", lat: lat, long: lon, isStation: true)
                
                self.stations.append(listItem)
            }
        }
    }
    
}
