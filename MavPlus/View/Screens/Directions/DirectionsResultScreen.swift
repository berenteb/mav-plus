import SwiftUI

struct DirectionsResultScreen: View {
    
    @ObservedObject var model: OfferViewModel
    
    var body: some View {
        List {
            DirectionsQuerySummary(model: self.model)
            Section(content: {
                ForEach(self.model.offers) { item in
                    NavigationLink {
                        DirectionsFinal(offer: item)
                    } label: {
                        DirectionsOfferView(offer: item)
                    }
                }
            }, header: {
                Text("Offers", comment: "Directions result section title")
            })
        }
        .navigationTitle(Text("Route", comment: "Directions result, tabview title"))
    }
}


 struct DirectionsResult_Previews: PreviewProvider {
     static var previews: some View {
         DirectionsResultScreen(model: OfferViewModel(start: FormStationListItem(code: "asd", name: "Szeged", searchCount: 4, isFavorite: true), end: FormStationListItem(code: "asd", name: "Szeged", searchCount: 6, isFavorite: false), passengerCount: 1, startDate: Date.now))
     }
 }
 
