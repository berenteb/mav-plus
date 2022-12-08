import SwiftUI
import MapKit

/// Map view showing the location of a single station
struct StationDetailsMapScreen: View {
            
    /// Data for the view.
    @ObservedObject var viewModel: StationDetailsViewModel
    
    /// The region of the location to display - required for SwiftUI Map
    @State private var region: MKCoordinateRegion
    
    /// The location to display
    @State private var item: LocationItem
    
    /// Default initializer
    /// - Parameter viewModel: The model of the station displayed
    init(viewModel: StationDetailsViewModel) {
        self.viewModel = viewModel
        self.item = LocationItem(id: viewModel.station!.name, name: viewModel.station!.name, lat: viewModel.station!.location!.latitude, long: viewModel.station!.location!.longitude)
        self.region = MKCoordinateRegion(
            center: viewModel.station!.location!,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
    }
    
    /// SwiftUI view generation.
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [item]) { loc in
            MapAnnotation(coordinate: loc.coordinate) {
                MapIcon("Station")
            }
        }.navigationTitle(viewModel.station!.name)
    }
}

///// SwiftUI Preview
//struct StationDetailsMapScreen_Previews: PreviewProvider {
//
//    /// SwiftUI Preview content generation.
//    static var previews: some View {
//        StationDetailsMapScreen(viewModel: StationDetailsViewModel(code: "00123455"))
//    }
//}
