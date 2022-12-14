import SwiftUI


/// Main TabView component containing every screen of tha app.
struct RootNavigation: View {
    
    /// The currently selected tab's tag.
    @State private var tabSelection: String = "home"
    
    /// Default initializer, sets up Theme.
    init() {
        Theme.setup()
    }
    
    /// SwiftUI view generation.
    var body: some View {
        TabView(selection: self.$tabSelection) {

            TrafficNews()
            .tabItem {
                Image(systemName: "exclamationmark.circle")
            }
            .tag("traffic")
            
            DirectionsFormScreen()
            .tabItem {
                Image("Directions")
            }
            .tag("directions")
            
            HomeScreen()
            .tabItem {
                Image("Home")
            }
            .tag("home")
            
            MavMap()
            .tabItem {
                Image("Map")
            }
            .tag("map")
            
            StationListScreen()
            .tabItem{
                Image("Station")
            }
            .tag("stations")
            
//            Settings()
//            .tabItem {
//                Image(systemName: "gearshape.2")
//            }
//            .tag("settings")
            
        }
    }
}

/// SwiftUI Preview
struct RootNavigation_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        RootNavigation()
    }
}
