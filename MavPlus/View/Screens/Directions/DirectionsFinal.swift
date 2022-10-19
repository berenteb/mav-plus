//
//  DirectionsFinal.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsFinal: View {
    @State var offer: OfferData
    
    var body: some View {
        List{
            Section("Route"){
                
            }
        }.navigationTitle("Ticket")
    }
}


struct DirectionsFinal_Previews: PreviewProvider {
    
    @State private static var navPath: NavigationPath = NavigationPath()
    
    static var previews: some View {
        DirectionsFinal(
            offer: OfferData(startStationName: "Vasalma", endStationName: "Jónásapátfalva", depDate: Date(), arrDate: Date(), price: "2000 HUF", travelTime: "234min", transferCount: 0)
        )
    }
}
