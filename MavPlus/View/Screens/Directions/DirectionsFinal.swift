//
//  DirectionsFinal.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsFinal: View {
    
    public let query: DirectionsQuery
    public let offer: OfferData
    
    var body: some View {
        GeometryReader { root in
            VStack {
                DirectionsQuerySummary(content: self.query)
                
                DirectionsOfferView(content: self.offer)
                .disabled(true)
                .frame(maxHeight: (root.size.height / 4))
                
                Spacer()
                Spacer()
                
                NormalButton(name: "Buy",
                             geo: root,
                             backgroundColor: Color.green,
                             action: {
                    // redirects to jegy.mav.hu
                })
                
                Spacer()
            }
            .navigationTitle("Route")
        }
    }
}

/*
struct DirectionsFinal_Previews: PreviewProvider {
    
    @State private static var navPath: NavigationPath = NavigationPath()
    
    static var previews: some View {
        DirectionsFinal(
            query: DirectionsQuery(time: Date.now, isDepartureTime: true, startStation: "Vasalma", endStation: "Jónásapátfalva", passengerNumber: 1, additionalOptions: ["With Bike"]),
            offer: DirectionsOffer(startTime: Date.now, endTime: Date.now, trainNumber: 2244, price: 2000, name: "Kékhullám", additionalInfo: "Seat reservation compulsory")
        )
    }
}
*/
