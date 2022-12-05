import SwiftUI

/// List view showing the results for a direction query
struct DirectionsResultScreen: View {
    
    /// Data for the view.
    @ObservedObject var model: OfferViewModel
    
    /// Default initializer
    /// Initializes self.model with the given parameters
    /// - Parameters:
    ///   - start: Start station data for the query
    ///   - end: End station data for the query
    ///   - passengerCount: Number of passengers for the query
    ///   - startDate: The date for the query
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
    
    /// SwiftUI view generation.
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

///// SwiftUI Preview
//struct DirectionsResult_Previews: PreviewProvider {
//
//    /// SwiftUI Preview content generation.
//    static var previews: some View {
//        DirectionsResultScreen(start: FormStationListItem(code: "asd", name: "Szeged", searchCount: 4, isFavorite: true), end: FormStationListItem(code: "asd", name: "Szeged", searchCount: 6, isFavorite: false), passengerCount: 1, startDate: Date.now)
//    }
//}

