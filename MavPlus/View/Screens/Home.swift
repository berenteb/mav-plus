//
//  Home.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct Home: View {
    
    @Binding public var tabSelection: String
    @ObservedObject var model: HomeViewModel = HomeViewModel()
    
    private func getTrafficNews() -> [RssItem] {
        let result: [RssItem] = [
            RssItem(title: "MyTitle", preview: "Something happened...", content: "Lorem ipsum dolor."),
            RssItem(title: "MyBestTitle", preview: "Something other happened...", content: "Lorem ipsum!"),
            RssItem(title: "YourTitle", preview: "Something different happened...", content: "Lorem dolor."),
        ]
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: CGFloat(5)) {
//                Group {
//                    Text("Recents")
//                    .font(.title2)
//                    .bold()
//
//                    ForEach(self.model.recentOffers) { directionItem in
//                        Group {
//                            Text(directionItem.startStationName) + Text("->") + Text(directionItem.endStationName)
//                        }
//                        .foregroundColor(Color.blue)
//                        .onTapGesture {
//                            self.tabSelection = "directions"
//                        }
//                    }
//                }
                
                Group {
                    Text("Favorites")
                    .font(.title2)
                    .bold()
                    
                    List(self.model.favoriteStations, id: \.code) { stationItem in
                        Text(stationItem.name)
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.tabSelection = "map"
                        }
                    }
                }
                
                Group {
                    Text("Alerts")
                    .font(.title2)
                    .bold()
                    
                    ForEach(self.getTrafficNews()) { newsItem in
                        Text(newsItem.title)
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.tabSelection = "traffic"
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

/*
struct Home_Previews: PreviewProvider {
    
    @State private static var isSelected: String = "home"
    
    static var previews: some View {
        Home(tabSelection: $isSelected)
    }
}
*/
