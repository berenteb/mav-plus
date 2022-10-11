//
//  HomeScreen.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 11..
//

import SwiftUI

struct HomeScreen: View {
    //@ObservedObject var homeViewModel: HomeViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                Section("Trip planner"){
                    Text("Not implemented")
                }
                Section("Recent offers"){
                    Text("Not implemented")
                }
                Section("Favorite stations"){
                    Text("Not implemented")
                }
            }.navigationTitle("Home")
        }.navigationViewStyle(.stack)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
