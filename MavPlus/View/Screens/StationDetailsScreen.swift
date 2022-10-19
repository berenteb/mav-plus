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
                ProgressView()
            }else if let station = viewModel.station{
                List{
                    if station.location != nil {
                        Section("Map"){
                            NavigationLink(destination:{
                                StationDetailsMapScreen(viewModel: viewModel)
                            },label:{
                                Label("Show on map", systemImage: "map.fill")
                            })
                        }
                    }
                    Section("Departures"){
                        ForEach(station.departures, id: \.trainCode){dep in
                            HStack{
                                Text(dep.destinationStationName)
                                Spacer()
                                Text(dep.departureDate?.formatted(date: .omitted, time: .standard) ?? "?")
                            }
                        }
                    }
                }
            }else{
                Text("Error")
            }
        }.navigationTitle(viewModel.station?.name ?? "Loading...")
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
