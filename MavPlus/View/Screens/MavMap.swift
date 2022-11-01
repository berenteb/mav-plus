import SwiftUI
import MapKit

struct MavMap: View {
    
    @StateObject private var model: MapViewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: self.$model.region, annotationItems: self.model.locations) { place in
                MapAnnotation(coordinate: place.location) {
                    MapIcon( (place.isStation ? "Station" : "Train") )
                }
            }.edgesIgnoringSafeArea(.top).overlay(alignment: .top){
                Rectangle().frame(height:0).background(.regularMaterial)
            }.onAppear{
                model.startTimer()
            }.onDisappear{
                model.stopTimer()
            }
    }
}

struct MavMap_Previews: PreviewProvider {
    static var previews: some View {
        MavMap()
    }
}
