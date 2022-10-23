import Foundation
import MapKit

protocol MapProtocol: RequestStatus, Updateable {
    var locations: [LocationItem] {get}
//    func stepUpdate() -> Void
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
//    private var upToDateLocations: [LocationItem]
//
//    private static let minimumDistance: Double = 0.5
    
    init(){
        isError = false
        isLoading = true
        locations = []
//        self.upToDateLocations = [LocationItem]()
        update()
        startTimer()
    }
    
//    private func evaluateCoordinateStep(originalItem: Double, item: Double) -> Double {
//        let distance: Double = ( originalItem - item )
//
//        var result: Double = originalItem
//        if (abs(distance) > MapViewModel.minimumDistance) {
//            var step: Double = abs(distance) / 100
//            if (step < MapViewModel.minimumDistance) {
//                step = MapViewModel.minimumDistance
//            }
//
//            if (distance > 0) {
//                step *= (-1)
//            }
//
//            result += step
//        }
//
//        return result
//    }
//
//    public func stepUpdate() -> Void {
//        var outputList: [LocationItem] = [LocationItem]()
//
//        for item in self.upToDateLocations {
//            if let originalItem: LocationItem = self.locations.first(where: { iterationItem in
//                return (iterationItem.id == item.id)
//            }) {
//                let latitudeResult: Double = self.evaluateCoordinateStep(originalItem: originalItem.location.latitude, item: item.location.latitude)
//                let longitudeResult: Double = self.evaluateCoordinateStep(originalItem: originalItem.location.longitude, item: item.location.longitude)
//
//                outputList.append(LocationItem(id: item.id, name: item.name, lat: latitudeResult, long: longitudeResult))
//            } else {
//                outputList.append(item)
//            }
//        }
//
//        self.locations = outputList
//    }
    
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
//                self.upToDateLocations = [LocationItem]()
                trains.forEach{ loc in
                    if let id = loc.VonatID, let name = loc.Vonatnev {
                        let lat = loc.EGpsLat ?? loc.GpsLat
                        let lon = loc.EGpsLon ?? loc.GpsLon
                        if let lon = lon, let lat = lat {
                            self.locations.append(LocationItem(id: id, name: name, lat: lat, long: lon))
//                            self.upToDateLocations.append(LocationItem(id: id, name: name, lat: lat, long: lon))
                        }
                    }
                }
            }
            self.isLoading = false
            
//            self.stepUpdate()
        }
    }
    
}
