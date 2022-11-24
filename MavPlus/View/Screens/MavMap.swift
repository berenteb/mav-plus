import SwiftUI
import MapKit

struct MavMap: View {
    
    @ObservedObject private var model: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationStack(path: self.$model.locationNavStack) {
            ZStack(alignment: .topLeading) {
                MapKitMap(model: self.model)
                .edgesIgnoringSafeArea(.top).overlay(alignment: .top){
                    Rectangle().frame(height:0).background(.regularMaterial)
                }
                .navigationDestination(for: LocationItem.self) { place in
                    Group {
                        if (place.isStation) {
                            StationDetailsScreen(code: place.id)
                        } else {
                            TrainDetailsScreen(trainId: Int(place.id) ?? 0)
                        }
                    }
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
}

//struct MavMap_Previews: PreviewProvider {
//    static var previews: some View {
//        MavMap()
//    }
//}
