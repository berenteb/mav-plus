import SwiftUI

/// View for direction query input, with TextInputs
struct DirectionsFormScreen: View {
    
    /// Data for the view.
    @ObservedObject var viewModel = DirectionsFormViewModel()
    
    /// The starting station for the query
    @State var startStation: FormStationListItem?
    
    /// The ending station for the query
    @State var endStation: FormStationListItem?
    
    /// The date for the query
    @State var time: Date = Date.now
    
    /// Whether the given date is the time to arrive by, or the time to leave at
    @State var isArrival: Bool = true
    
    /// The number of passengers
    @State var passengerNumber: Int = 1
    
    /// SwiftUI view generation.
    var body: some View {
        GeometryReader { root in
            NavigationStack {
                VStack {
                    Form {
                        Section(content: {
                            StationPickerField(label: Text("From"), list: viewModel.stationList, selectedStation: $startStation)
                            StationPickerField(label: Text("To"), list: viewModel.stationList, selectedStation: $endStation)
                        }, header: {
                            Text("Route")
                        })
                        
                        Section(content: {
                            DatePicker(selection: $time) {
                                Text("Date")
                            }
                            Toggle(isOn: $isArrival) {
                                Text("Arrive by")
                            }
                        }, header: {
                            Text("Date")
                        })
                        
                        Section(content: {
                            Stepper(value: $passengerNumber, in: 1...10) {
                                Text("Count:") + Text(" \(self.passengerNumber)")
                            }
                        }, header: {
                            Text("Passengers")
                        })
                        
                        if let startStation = startStation, let endStation = endStation {
                                NavigationLink(destination: {
                                    DirectionsResultScreen(start: startStation, end: endStation, passengerCount: self.passengerNumber, startDate: self.time)
                                }, label: {
                                    Label(title: {
                                        Text("Search")
                                    }, icon: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .foregroundColor(.black)
                                }).listRowBackground(Color("Primary"))
                        }
                    }
                    
                }
                .navigationTitle(Text("Directions"))
            }
        }
    }
}

/// SwiftUI Preview
struct Directions_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        DirectionsFormScreen(startStation: FormStationListItem(code: "Teszt", name: "Teszt", searchCount: 3, isFavorite: false), endStation: FormStationListItem(code: "Teszt", name: "Teszt", searchCount: 2, isFavorite: false))
    }
}
