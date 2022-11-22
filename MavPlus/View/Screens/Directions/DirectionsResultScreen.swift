import SwiftUI

struct DirectionsResultScreen: View {
    
    @ObservedObject var model: OfferViewModel
    
    init(
        start: FormStationListItem,
        end: FormStationListItem,
        passengerCount: Int, startDate: Date
    ) {
        self.model = OfferViewModel(
            start: start,
            end: end,
            passengerCount: passengerCount,
            startDate: startDate)
        model.update()
    }
    
    var body: some View {
        if model.isLoading{
            SpinnerView()
        }else if model.isError {
            ErrorView(onRetry: model.update)
        }else{
            List {
                DirectionsQuerySummary(
                    startStationName: model.start.name,
                    endStationName: model.end.name,
                    passengerCount: model.passengerCount,
                    startDate: model.startDate)
                Section(content: {
                    ForEach(self.model.offers) { item in
                        NavigationLink {
                            DirectionsFinal(offer: item)
                        } label: {
                            DirectionsOfferListItem(offer: item)
                        }
                    }
                }, header: {
                    Text("Offers")
                })
            }
            .navigationTitle(Text("Route"))
        }
    }
}


//struct DirectionsResult_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsResultScreen(start: FormStationListItem(code: "asd", name: "Szeged", searchCount: 4, isFavorite: true), end: FormStationListItem(code: "asd", name: "Szeged", searchCount: 6, isFavorite: false), passengerCount: 1, startDate: Date.now)
//    }
//}

