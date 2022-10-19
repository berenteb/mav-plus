import SwiftUI

struct DirectionsResultScreen: View {
    
    @ObservedObject var model: OfferViewModel
    
    var body: some View {
        List {
            DirectionsQuerySummary(model: self.model)
            Section("Offers"){
                ForEach(self.model.offers) { item in
                    NavigationLink {
                        DirectionsFinal(offer: item)
                    } label: {
                        DirectionsOfferView(offer: item)
                    }
                }
            }
        }
        .navigationTitle("Route")
    }
}


 struct DirectionsResult_Previews: PreviewProvider {
     static var previews: some View {
         DirectionsResultScreen(model: OfferViewModel(start: FormStationListItem(code: "asd", name: "Szeged"), end: FormStationListItem(code: "asd", name: "Szeged"), passengerCount: 1, startDate: Date.now))
     }
 }
 
