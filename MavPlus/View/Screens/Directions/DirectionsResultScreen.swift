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
         DirectionsResultScreen(model: OfferViewModel(start: FormStationListItem(code: "asd", name: "Szeged"), end: FormStationListItem(code: "asd", name: "Szeged"), passengerCount: 1, startDate: Date.now))
     }
 }
 
