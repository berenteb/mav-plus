import SwiftUI

struct HomeScreen: View {
    
    @Binding public var tabSelection: String
    @ObservedObject var model: HomeViewModel = HomeViewModel()
    @ObservedObject var trafficNewsModel: RssViewModel
    
    func removeRecent(index: IndexSet) {
        guard let i = index.first else {return}
        let item = model.recentOffers[i]
        StoreRepository.shared.deleteRecentOffer(id:item.id)
    }
    
    func removeFavorite(index: IndexSet) {
        guard let i = index.first else {return}
        let item = model.favoriteStations[i]
        StoreRepository.shared.deleteFavoriteStation(code: item.code)
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
                    }.onDelete(perform: removeRecent)
                }
                
                Section("Favorites") {
                    ForEach(self.model.favoriteStations, id: \.code) { stationItem in
                        NavigationLink(stationItem.name){
                            StationDetailsScreen(code: stationItem.code)
                        }
                    }.onDelete(perform: removeFavorite)
                }
                
                Section("Alerts") {
                    ForEach(self.trafficNewsModel.rssItemList) { newsItem in
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

//struct Home_Previews: PreviewProvider {
//
//    @State private static var isSelected: String = "home"
//
//    static var previews: some View {
//        HomeScreen(tabSelection: $isSelected)
//    }
//}
