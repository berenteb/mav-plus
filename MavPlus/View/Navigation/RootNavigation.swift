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
    
    var body: some View {
        TabView(selection: self.$tabSelection) {

            TrafficNews(model: self.trafficNewsModel)
            .tabItem {
                Image(systemName: "exclamationmark.triangle")
            }
            .tag("traffic")
            
            DirectionsFormScreen()
            .tabItem {
                Image(systemName: "signpost.right")
            }
            .tag("directions")
            
            HomeScreen(tabSelection: self.$tabSelection, trafficNewsModel: trafficNewsModel)
            .tabItem {
                Image(systemName: "house")
            }
            .tag("home")
            
            MavMap()
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
