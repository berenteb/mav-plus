import SwiftUI

struct DirectionsFormScreen: View {
    @ObservedObject var viewModel = DirectionsFormViewModel()
    @State var startStation: FormStationListItem?
    @State var endStation: FormStationListItem?
    @State var time: Date = Date.now
    @State var isArrival: Bool = true
    @State var passengerNumber: Int = 1
    
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


struct Directions_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsFormScreen(startStation: FormStationListItem(code: "Teszt", name: "Teszt", searchCount: 3, isFavorite: false), endStation: FormStationListItem(code: "Teszt", name: "Teszt", searchCount: 2, isFavorite: false))
    }
}
