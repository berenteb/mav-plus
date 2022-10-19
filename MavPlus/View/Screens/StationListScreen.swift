//
//  StationListView.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 11..
//

import SwiftUI

struct StationListScreen: View {
    @ObservedObject var viewModel: StationListViewModel = StationListViewModel()
    @State var searchText = ""
    var body: some View {
        NavigationView{
            List(filteredStations, id:\.code ){ item in
                NavigationLink(item.name){
                    StationDetailsScreen(code: item.code)
                }
            }.onAppear{
                viewModel.update()
            }.refreshable {
                viewModel.update()
            }.navigationTitle("Stations")
        }
        .navigationViewStyle(.stack)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
    var filteredStations: [StationListItem] {
        if searchText.isEmpty {
            return viewModel.stationList
        } else {
            return viewModel.stationList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListScreen()
    }
}
