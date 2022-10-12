//
//  Directions.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct Directions: View {
    @State var from: String = ""
    @State var to: String = ""
    
    var body: some View {
        GeometryReader { root in
            NavigationStack {
                VStack {
                    TextField("Origin", text: $from)
                    .frame(maxWidth: (root.size.width / 2))
                    .padding(CGFloat(5))
                    .cornerRadius(CGFloat(5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 2)
                    )
                    TextField("Destination", text: $to)
                    .frame(maxWidth: (root.size.width / 2))
                    .padding(CGFloat(5))
                    .cornerRadius(CGFloat(5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 2)
                    )
                    
                    NavigationLink {
                        DirectionsResult(
                            query:
                                DirectionsQuery(
                                    time: Date(),
                                    isDepartureTime: true,
                                    startStation: from,
                                    endStation: to,
                                    passengerNumber: 2
                                ),
                            model: OfferViewModel(start: from, end: to, count: 2)
                        )
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

/*
struct Directions_Previews: PreviewProvider {
    static var previews: some View {
        Directions()
    }
}
*/
