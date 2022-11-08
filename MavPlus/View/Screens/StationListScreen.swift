//
//  StationListView.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 11..
//

import SwiftUI

struct StationListScreen: View {
    @ObservedObject var searchField = TextFieldDebouncer()
    @ObservedObject var viewModel: StationListViewModel = StationListViewModel()
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
            }.navigationTitle(Text("Stations", comment: "Station list tabview title"))
        }
        .navigationViewStyle(.stack)
        .searchable(
            text: $searchField.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
    var filteredStations: [StationListItem] {
        if searchField.debouncedText.isEmpty {
            return viewModel.stationList
        } else {
            return viewModel.stationList.filter { $0.name.localizedCaseInsensitiveContains(searchField.debouncedText) }
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListScreen()
    }
}
