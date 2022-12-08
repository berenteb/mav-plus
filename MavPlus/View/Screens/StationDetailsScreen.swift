import SwiftUI

/// View showing the details of a station (e.g. location, name, train departures, etc.)
struct StationDetailsScreen: View {
    
    /// Data for the view.
    @ObservedObject var model: StationDetailsViewModel
    
    /// The code of the station presented
    let code: String
    
    /// Default initializer
    /// - Parameter code: The code of the station to present
    init(code: String) {
        self.code = code
        self.model = StationDetailsViewModel(code: code)
    }
    
    /// SwiftUI view generation.
    var body: some View {
        VStack{
            if model.isLoading{
                SpinnerView()
            }else if model.isError{
                ErrorView(onRetry: model.update)
            }else if let station = model.station{
                List{
                    if station.location != nil {
                        Section(content: {
                            NavigationLink(destination:{
                                StationDetailsMapScreen(viewModel: model)
                            },label:{
                                Label(title: {
                                    Text("Show on map")
                                }, icon: {
                                    Image(systemName: "map.fill")
                                })
                            })
                        }, header: {
                            Text("Map")
                        })
                    }
                    
                    Section(content: {
                        ForEach(station.departures){dep in
                            if let trainId = dep.trainId {
                                NavigationLink(destination: TrainDetailsScreen(trainId: trainId)){
                                    DepartureListItem(dep: dep)
                                }
                            }else {
                                DepartureListItem(dep: dep)
                            }
                            
                        }
                    }, header: {
                        Text("Departures")
                    })
                }
            }else{
                Text("Error")
            }
        }
        .navigationTitle(
            Text(self.model.station?.name ?? NSLocalizedString("Loading...", comment: "Station details loading"))
        )
        .toolbar{
            if let isFavorite = model.station?.isFavorite {
                Image(
                    systemName:
                        isFavorite ? "star.slash.fill" : "star").foregroundColor(Color.yellow).onTapGesture{
                            model.toggleFavorite()
                        }
            }
        }.onAppear{
            model.update()
        }
    }
}

struct DepartureListItem: View{
    let dep: Departure
    var body: some View {
        HStack{
            TrainListItem(trainData: TrainListItemData(pictogram: dep.trainPictogram, trainName: dep.trainName, destination: dep.destinationStationName))
            Spacer()
            VStack(alignment: .leading){
                Text(dep.departureDate?.formatted(date: .omitted, time:.shortened) ?? "?")
                    .strikethrough(dep.isDelayed)
                    .foregroundColor(!dep.isDelayed && dep.corrigatedDepartureDate != nil ? .green : nil)
                if let actualDate = dep.corrigatedDepartureDate{
                    if dep.isDelayed{
                        Text(actualDate.formatted(date: .omitted, time: .shortened))
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct StationDetailsScreen_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        StationDetailsScreen(code: "005517228")
    }
}
