import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var model: HomeViewModel = HomeViewModel()
    
    func removeRecent(index: IndexSet) {
        guard let i = index.first else {return}
        let item = model.recentOffers[i]
        StoreRepository.shared.deleteRecentOffer(id:item.id)
    }
    
    func removeFavorite(index: IndexSet) {
        guard let i = index.first else {return}
        let item = model.favoriteStations[i]
        StoreRepository.shared.saveFavoriteStation(code: item.code, searchCount: item.searchCount, isFavorite: false)
    }
    
    private func generateFormStationListItem(code: String, name: String) -> FormStationListItem {
        return FormStationListItem(
            code: code,
            name: name,
            searchCount: StoreRepository.shared.favoriteStationSearchCount(code: code),
            isFavorite: StoreRepository.shared.isFavoriteStation(code: code)
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    ForEach(self.model.recentOffers) { directionItem in
                        NavigationLink(destination: {
                            DirectionsResultScreen(
                                start: generateFormStationListItem(
                                    code: directionItem.startStationCode,
                                    name: directionItem.startStationName
                                ),
                                end: generateFormStationListItem(
                                    code: directionItem.endStationCode,
                                    name: directionItem.endStationName),
                                passengerCount: 1,
                                startDate: Date.now)
                        }, label: {
                            VStack(alignment: .leading, spacing: 5){
                                Text(directionItem.startStationName)
                                Text(directionItem.endStationName)
                            }
                        })
                    }.onDelete(perform: removeRecent)
                }, header: {
                    Text("Recents")
                })
                
                Section(content: {
                    ForEach(self.model.favoriteStations, id: \.code) { stationItem in
                        NavigationLink(stationItem.name){
                            StationDetailsScreen(code: stationItem.code)
                        }
                    }.onDelete(perform: removeFavorite)
                }, header: {
                    Text("Favorites")
                })
                
                Section(content: {
                    ForEach(self.model.alerts) { alert in
                        if let url: URL = URL(string: alert.url) {
                            NavigationLink(destination: {
                                WebView(url: url).navigationBarTitleDisplayMode(.inline)
                            }, label: {
                                IconField(iconName: "exclamationmark.triangle", value: alert.title)
                            })
                        } else {
                            IconField(iconName: "exclamationmark.triangle", value: alert.title)
                        }
                    }
                }, header: {
                    Text("Alerts")
                })
            }
            .navigationTitle(Text("Home"))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
