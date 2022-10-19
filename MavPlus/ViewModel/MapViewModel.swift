import Foundation
import MapKit

protocol MapProtocol: RequestStatus, Updateable {
    var locations: [LocationItem] {get}
}

struct LocationItem: Identifiable {
    let id: String
    let name: String
    let location: CLLocationCoordinate2D
    init(id: String, name: String, lat: Double, long: Double) {
        self.id = id
        self.name = name
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
    init(){
        isError = false
        isLoading = true
        locations = []
        update()
        startTimer()
    }
    
    private func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.update()
        }
    }
    
    func update() {
        isLoading = true
        trainLocationRequest(){ locations, error in
            self.isError = error != nil
            if let trains = locations?.Vonatok {
                self.locations = []
                trains.forEach{ loc in
                    if let id = loc.VonatID, let name = loc.Vonatnev {
                        let lat = loc.EGpsLat ?? loc.GpsLat
                        let lon = loc.EGpsLon ?? loc.GpsLon
                        if let lon = lon, let lat = lat {
                            self.locations.append(LocationItem(id: id, name: name, lat: lat, long: lon))
                        }
                    }
                }
            }
            self.isLoading = false
        }
    }
    
}
