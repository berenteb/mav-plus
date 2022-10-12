//
//  DirectionsResult.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-04.
//

import SwiftUI

struct DirectionsResult: View {
    
    public let query: DirectionsQuery
    @ObservedObject var model: OfferViewModel
    
    var body: some View {
        VStack {
            DirectionsQuerySummary(content: self.query)
            Group {
//                if (self.model.isLoading) {
//                    ProgressView()
//                }
                List(self.model.offers) { item in
                    NavigationLink {
                        DirectionsFinal(query: self.query, offer: item)
                    } label: {
                        DirectionsOfferView(content: item)
                            .disabled(true)
                    }
                }.refreshable {
                    model.update()
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Route")
    }
}

/*
 struct DirectionsResult_Previews: PreviewProvider {
 static var previews: some View {
 DirectionsResult(query: DirectionsQuery(time: Date.now, isDepartureTime: true, startStation: "Vasalma", endStation: "Jónásapátfalva", passengerNumber: 1, additionalOptions: ["With Bike"]))
 }
 }
 */
