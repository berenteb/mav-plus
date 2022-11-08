//
//  DirectionsQuerySummary.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQuerySummary: View {
    
    @ObservedObject public var model: OfferViewModel
    
    var body: some View {
        
        Section(content: {
            HStack{
                Image("Directions").foregroundColor(Color("Secondary")).rotationEffect(Angle(degrees: 90))
                VStack(alignment: .leading){
                    Text(model.start.name)
                    Text(model.end.name)
                }
            }
            HStack{
                Image("Person").foregroundColor(Color("Secondary"))
                Text(String(model.passengerCount))
            }
            HStack{
                Image("Calendar").foregroundColor(Color("Secondary"))
                Text(model.startDate.formatted(date: .long, time: .shortened))
            }
        }, header: {
            Text("Parameters", comment: "Directions query summary component title")
        })
    }
}

struct DirectionsQuerySummary_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQuerySummary(model: OfferViewModel(start: FormStationListItem(code: "asd", name: "Szeged"), end: FormStationListItem(code: "asd", name: "Szeged"), passengerCount: 1, startDate: Date.now))
    }
}
