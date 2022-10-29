//
//  RootNavigation.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct RootNavigation: View {
    
    @State private var tabSelection: String = "home"
    @StateObject private var trafficNewsModel: RssViewModel = RssViewModel()
    
    init() {
        Theme.setup()
    }
    
    var body: some View {
        TabView(selection: self.$tabSelection) {

            TrafficNews(model: self.trafficNewsModel)
            .tabItem {
                Image(systemName: "exclamationmark.circle")
            }
            .tag("traffic")
            
            DirectionsFormScreen()
            .tabItem {
                Image("Directions")
            }
            .tag("directions")
            
            HomeScreen(tabSelection: self.$tabSelection, trafficNewsModel: trafficNewsModel)
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

struct RootNavigation_Previews: PreviewProvider {
    static var previews: some View {
        RootNavigation()
    }
}
