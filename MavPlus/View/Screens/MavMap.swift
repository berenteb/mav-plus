import SwiftUI
import MapKit

struct MavMap: View {
    
    @StateObject private var model: MapViewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Map(coordinateRegion: self.$model.region, annotationItems: self.model.locations) { place in
                MapAnnotation(coordinate: place.location) {
                    MapIcon( (place.isStation ? "Station" : "Train") )
                }
            }
            .edgesIgnoringSafeArea(.top).overlay(alignment: .top){
                Rectangle().frame(height:0).background(.regularMaterial)
            }
            .onAppear{
                model.startTimer()
            }
            .onDisappear{
                model.stopTimer()
            }
            
            VStack(alignment: .trailing) {
                Text("Show stations")
                .bold()
                .padding(5)
                .background(Color("Secondary"))
                .cornerRadius(10)
                Toggle("", isOn: self.$model.showStations)
            }
            .padding()
        }
    }
}

struct MavMap_Previews: PreviewProvider {
    static var previews: some View {
        MavMap()
    }
}
