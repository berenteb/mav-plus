//
//  DirectionsFinal.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsFinal: View {
    
    @ObservedObject public var model: OfferViewModel
    public let offer: OfferData
    
    var body: some View {
        GeometryReader { root in
            VStack {
                DirectionsQuerySummary(model: self.model)
                
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


struct DirectionsFinal_Previews: PreviewProvider {
    
    @State private static var navPath: NavigationPath = NavigationPath()
    
    static var previews: some View {
        DirectionsFinal(
            model: OfferViewModel(start: "Vasalma", end: "Jónásapátfalva", count: 1, date: Date.now),
            offer: OfferData(startStationName: "Vasalma", endStationName: "Jónásapátfalva", price: "2000 HUF", travelTime: "234min", transferCount: 0)
        )
    }
}
