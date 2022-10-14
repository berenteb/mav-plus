//
//  Directions.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

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
                    Form{
                        Section("Route"){
                            StationPickerField(label: "From", list: viewModel.stationList, selectedStation: $startStation)
                            StationPickerField(label: "To", list: viewModel.stationList, selectedStation: $endStation)
                        }
                        Section("Date"){
                            DatePicker("Date", selection: $time)
                            Toggle("Arrive by", isOn: $isArrival)
                        }
                        Section("Passengers"){
                            Stepper("Count: \(passengerNumber)", value: $passengerNumber, in: 1...10)
                        }
                        if let startStation = startStation, let endStation = endStation {
                            Section{
                                NavigationLink(destination: {
                                    DirectionsResultScreen(model: OfferViewModel(start: startStation, end: endStation, passengerCount: passengerNumber, startDate: time))
                                }, label: {
                                    Text("Search")
                                })
                            }
                        }
                    }
                }
                .navigationTitle("Directions")
            }
        }
    }
}


struct Directions_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsFormScreen()
    }
}
