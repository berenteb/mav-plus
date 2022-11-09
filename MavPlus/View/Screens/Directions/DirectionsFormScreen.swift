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
                    Form {
                        Section(content: {
                            StationPickerField(label: Text("From", comment: "Directions input, origin"), list: viewModel.stationList, selectedStation: $startStation)
                            StationPickerField(label: Text("To", comment: "Directions input, destination"), list: viewModel.stationList, selectedStation: $endStation)
                        }, header: {
                            Text("Route", comment: "Directions input, origin/destination section title")
                        })
                        
                        Section(content: {
                            DatePicker(selection: $time) {
                                Text("Date", comment: "Directions input, date selection")
                            }
                            Toggle(isOn: $isArrival) {
                                Text("Arrive by", comment: "Directions input, arrive by toggle")
                            }
                        }, header: {
                            Text("Date", comment: "Directions input, date section title")
                        })
                        
                        Section(content: {
                            Stepper(value: $passengerNumber, in: 1...10) {
                                Text("Count:", comment: "Directions input, passenger count title") + Text(" \(self.passengerNumber)")
                            }
                        }, header: {
                            Text("Passengers", comment: "Directions input, passenger section title")
                        })
                        
                        if let startStation = startStation, let endStation = endStation {
                                NavigationLink(destination: {
                                    DirectionsResultScreen(model: self.viewModel.createOfferViewModel(start: startStation, end: endStation, count: self.passengerNumber, startDate: self.time))
                                }, label: {
                                    Label(title: {
                                        Text("Search", comment: "Directions input, go button")
                                    }, icon: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .foregroundColor(.black)
                                }).listRowBackground(Color("Primary"))
                        }
                    }
                    
                }
                .navigationTitle(Text("Directions", comment: "Directions input tabview title"))
            }
        }
    }
}


struct Directions_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsFormScreen(startStation: FormStationListItem(code: "Teszt", name: "Teszt", searchCount: 3, isFavorite: false), endStation: FormStationListItem(code: "Teszt", name: "Teszt", searchCount: 2, isFavorite: false))
    }
}
