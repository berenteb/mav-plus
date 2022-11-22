import SwiftUI
import MapKit

struct StationDetailsMapScreen: View {
    @ObservedObject var viewModel: StationDetailsViewModel
    @State private var region: MKCoordinateRegion
    @State private var item: LocationItem
    
    init(viewModel: StationDetailsViewModel) {
        self.viewModel = viewModel
        self.item = LocationItem(id: viewModel.station!.name, name: viewModel.station!.name, lat: viewModel.station!.location!.latitude, long: viewModel.station!.location!.longitude)
        self.region = MKCoordinateRegion(
            center: viewModel.station!.location!,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [item]) { loc in
            MapAnnotation(coordinate: loc.location) {
                MapIcon("Station")
            }
        }.navigationTitle(viewModel.station!.name)
    }
}

//struct StationDetailsMapScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        StationDetailsMapScreen(viewModel: StationDetailsViewModel(code: "00123455"))
//    }
//}
