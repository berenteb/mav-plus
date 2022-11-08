//
//  StationDetailsScreen.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 11..
//

import SwiftUI

struct StationDetailsScreen: View {
    @ObservedObject var viewModel: StationDetailsViewModel
    let code: String
    
    init(code: String) {
        self.code = code
        self.viewModel = StationDetailsViewModel(code: code)
    }
    
    var body: some View {
        VStack{
            if viewModel.isLoading {
                SpinnerView()
            }else if let station = viewModel.station{
                List{
                    if station.location != nil {
                        Section(content: {
                            NavigationLink(destination:{
                                StationDetailsMapScreen(viewModel: viewModel)
                            },label:{
                                Label(title: {
                                    Text("Show on map", comment: "Station details, map button prompt")
                                }, icon: {
                                    Image(systemName: "map.fill")
                                })
                            })
                        }, header: {
                            Text("Map", comment: "Station details, map section title")
                        })
                    }
                    
                    Section(content: {
                        ForEach(station.departures){dep in
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
                    }, header: {
                        Text("Departures", comment: "Station details, departures section title")
                    })
                }
            }else{
                Text("Error", comment: "Station details error")
            }
        }
        .navigationTitle(
            Text(self.viewModel.station?.name ?? NSLocalizedString("Loading...", comment: "Station details loading"))
        )
        .toolbar{
            if let isFavorite = viewModel.station?.isFavorite {
                Image(systemName: isFavorite ? "star.slash.fill" : "star").foregroundColor(Color.yellow).onTapGesture{
                    viewModel.toggleFavorite()
                }
            }
        }.onAppear{
            viewModel.update()
        }
    }
}

struct StationDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailsScreen(code: "")
    }
}
