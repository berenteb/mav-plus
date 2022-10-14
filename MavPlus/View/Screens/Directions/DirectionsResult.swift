//
//  DirectionsResult.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-04.
//

import SwiftUI

struct DirectionsResult: View {
    
    @ObservedObject var model: OfferViewModel
    
    var body: some View {
        VStack {
            DirectionsQuerySummary(model: self.model)
            Group {
                if (self.model.isLoading) {
                    ProgressView()
                }
                List(self.model.offers) { item in
                    NavigationLink {
                        DirectionsFinal(model: self.model, offer: item)
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


 struct DirectionsResult_Previews: PreviewProvider {
     static var previews: some View {
         DirectionsResult(model: OfferViewModel(start: "Vasalma", end: "Jónásapátfalva", count: 1, date: Date.now))
     }
 }
 
