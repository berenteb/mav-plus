//
//  StationListView.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 11..
//

import SwiftUI

struct StationListScreen: View {
    @ObservedObject var viewModel: StationListViewModel = StationListViewModel()
    var body: some View {
        NavigationView{
                List(viewModel.stationList, id:\.code ){ item in
                    NavigationLink(item.name){
                        StationDetailsScreen(code: item.code)
                    }
                }.onAppear{
                    viewModel.update()
                }.refreshable {
                    viewModel.update()
                }.navigationTitle("Stations")
        }.navigationViewStyle(.stack)
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListScreen()
    }
}
