import SwiftUI

struct HomeScreen: View {
    
    @Binding public var tabSelection: String
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
    
    private func generateOfferViewModel(inputOffer: RecentOfferListItem) -> OfferViewModel {
        let start: FormStationListItem = FormStationListItem(
                                                                code: inputOffer.startStationCode,
                                                                name: inputOffer.startStationName,
                                                                searchCount: StoreRepository.shared.favoriteStationSearchCount(code: inputOffer.startStationCode),
                                                                isFavorite: StoreRepository.shared.isFavoriteStation(code: inputOffer.startStationCode)
                                                            )
        let end: FormStationListItem = FormStationListItem(
                                                                code: inputOffer.endStationCode,
                                                                name: inputOffer.endStationName,
                                                                searchCount: StoreRepository.shared.favoriteStationSearchCount(code: inputOffer.endStationCode),
                                                                isFavorite: StoreRepository.shared.isFavoriteStation(code: inputOffer.endStationCode)
                                                            )
        
        let result: OfferViewModel = OfferViewModel(start: start, end: end, passengerCount: 1, startDate: Date.now)
        
        return result
    }
        
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    ForEach(self.model.recentOffers) { directionItem in
                        NavigationLink(destination: {
                            DirectionsResultScreen(model: self.generateOfferViewModel(inputOffer: directionItem))
                        }, label: {
                            VStack(alignment: .leading, spacing: 5){
                                Text(directionItem.startStationName)
                                Text(directionItem.endStationName)
                            }
                        })
                    }.onDelete(perform: removeRecent)
                }, header: {
                    Text("Recents", comment: "Recent direction queries section title")
                })
                
                Section(content: {
                    ForEach(self.model.favoriteStations, id: \.code) { stationItem in
                        NavigationLink(stationItem.name){
                            StationDetailsScreen(code: stationItem.code)
                        }
                    }.onDelete(perform: removeFavorite)
                }, header: {
                    Text("Favorites", comment: "Favorite stations section title")
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
                    Text("Alerts", comment: "RSS links section title")
                })
            }
            .navigationTitle(Text("Home", comment: "Home tabview title"))
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
