import SwiftUI

/// View presenting the details of a train (e.g. name, stops, how late it is, etc.)
struct TrainDetailsScreen: View {
    
    /// Data for the view.
    @ObservedObject var model: TrainViewModel
    
    /// Default initializer
    /// - Parameter trainId: The id of the train to present
    init(trainId: Int) {
        self.model = TrainViewModel(trainId: trainId)
    }
    
    /// SwiftUI view generation.
    var body: some View {
        VStack{
            if model.isLoading {
                SpinnerView()
            }else if model.isError {
                ErrorView(onRetry: model.update)
            }else if let train = model.trainData{
                List{
                    Section(content: {
                        HStack{
                            Image("Directions").foregroundColor(Color("Secondary")).rotationEffect(Angle(degrees: 90))
                            VStack(alignment: .leading){
                                Text(train.startStationName)
                                Text(train.endStationName)
                            }
                        }
                        HStack{
                            if let pictogram = train.trainPictogram{
                                Text(pictogram.name)
                                    .bold()
                                    .foregroundColor(Color(hex: pictogram.foregroundColor))
                            }
                            Text(train.name)
                        }
                        
                    }, header: {
                        Text("Details")
                    })
                    Section(content: {
                        ForEach(train.stations, id: \.name){ stop in
                            HStack(spacing:10){
                                Text(stop.date?.formatted(date: .omitted, time: .shortened) ?? "?")
                                Text(stop.name)
                            }
                        }
                    }, header: {
                        Text("Route")
                    })
                }
            }
        }
        .navigationTitle(
            Text(self.model.trainData?.name ?? NSLocalizedString("Loading", comment: "Loading text") )
        ).onAppear{
            model.update()
        }
    }
}

/// SwiftUI Preview
struct TrainDetailsScreen_Previews: PreviewProvider {

    /// SwiftUI Preview content generation.
    static var previews: some View {
        TrainDetailsScreen(trainId: 649641)
    }
}
