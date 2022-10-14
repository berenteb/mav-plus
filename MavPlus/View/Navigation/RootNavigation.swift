//
//  RootNavigation.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct RootNavigation: View {
    
    @State private var tabSelection: String = "home"
    
    var body: some View {
        TabView(selection: self.$tabSelection) {

            TrafficNews()
            .tabItem {
                Image(systemName: "exclamationmark.triangle")
            }
            .tag("traffic")
            
            Directions()
            .tabItem {
                Image(systemName: "signpost.right")
            }
            .tag("directions")
            
            Home(tabSelection: self.$tabSelection)
            .tabItem {
                Image(systemName: "house")
            }
            .tag("home")
            
            MavMap(model: MapViewModel())
            .tabItem {
                Image(systemName: "map")
            }
            .tag("map")
            
            StationListScreen()
            .tabItem{
                Image(systemName: "list.bullet")
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

struct RootNavigation_Previews: PreviewProvider {
    static var previews: some View {
        RootNavigation()
    }
}
