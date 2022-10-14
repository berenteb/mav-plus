import SwiftUI

struct HomeScreen: View {
    
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
            List {
                Section("Recents") {
                    ForEach(self.model.recentOffers) { directionItem in
                        NavigationLink(destination: {
                            DirectionsResultScreen(model:OfferViewModel(start: FormStationListItem(code: directionItem.startStationCode, name: directionItem.startStationName), end: FormStationListItem(code: directionItem.endStationCode, name: directionItem.endStationName), passengerCount: 1, startDate: Date.now))
                        }, label: {
                            VStack(alignment: .leading, spacing: 5){
                                Text(directionItem.startStationName)
                                Text(directionItem.endStationName)
                            }
                        })
                    }
                }
                
                Section("Favorites") {
                    ForEach(self.model.favoriteStations, id: \.code) { stationItem in
                        NavigationLink(stationItem.name){
                            StationDetailsScreen(code: stationItem.code)
                        }
                    }
                }
                
                Section("Alerts") {
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

struct Home_Previews: PreviewProvider {
    
    @State private static var isSelected: String = "home"
    
    static var previews: some View {
        HomeScreen(tabSelection: $isSelected)
    }
}
