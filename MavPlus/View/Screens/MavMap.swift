import SwiftUI
import MapKit

struct MavMap: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.497854,
                                       longitude: 19.040170),
        latitudinalMeters: 10000,
        longitudinalMeters: 10000
    )
    
    @StateObject private var model: MapViewModel = MapViewModel()
    
    var body: some View {
            Map(coordinateRegion: self.$region, annotationItems: self.model.locations) { place in
                MapAnnotation(coordinate: place.location) {
                    MapIcon( (place.isStation ? "Station" : "Train") )
                }
            }.edgesIgnoringSafeArea(.top).overlay(alignment: .top){
                Rectangle().frame(height:0).background(.regularMaterial)
        }
    }
}

struct MavMap_Previews: PreviewProvider {
    static var previews: some View {
        MavMap()
    }
}
