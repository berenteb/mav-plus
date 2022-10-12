//
//  Directions.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct Directions: View {
    
    @State private var startStation: String = String()
    @State private var endStation: String = String()
    @State private var time: Date = Date.now
    @State private var isDeparture: Bool = true
    @State private var passengerNumber: Int = 1
    
    var body: some View {
        GeometryReader { root in
            NavigationStack {
                VStack {
                    DirectionsQueryInput(
                        startStation: self.$startStation,
                        endStation: self.$endStation,
                        time: self.$time,
                        isDeparture: self.$isDeparture,
                        passengerNumber: self.$passengerNumber
                    )
                    
                    NavigationLink {
                        DirectionsResult(model: OfferViewModel(
                                                                start: self.startStation,
                                                                end: self.endStation,
                                                                count: self.passengerNumber,
                                                                date: self.time
                        ))
                    } label: {
                        NormalButton(name: "Plan", geo: root, backgroundColor: Color.green, action: {})
                        .disabled(true)
                        .foregroundColor(Color.black)
                    }
                }
                .navigationTitle("Route")
                .padding()
            }
        }
    }
}


struct Directions_Previews: PreviewProvider {
    static var previews: some View {
        Directions()
    }
}
