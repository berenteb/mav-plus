//
//  LoadingScreen.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 30..
//

import SwiftUI

struct LoadingScreen: View {
    @ObservedObject var model = LoadingViewModel()
    var body: some View {
        if model.isLoading{
            Spinner()
        }else if model.isError{
            Text("Error")
        }else{
            RootNavigation()
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
