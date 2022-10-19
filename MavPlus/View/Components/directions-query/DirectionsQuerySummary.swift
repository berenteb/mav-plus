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
        
        Section("Parameters"){
            HStack{
                Image(systemName: "app.connected.to.app.below.fill")
                VStack(alignment: .leading){
                    Text(model.start.name)
                    Text(model.end.name)
                }
            }
            IconField(iconName: "person", value: String(model.passengerCount))
            IconField(iconName: "clock", value: model.startDate.formatted(date: .long, time: .shortened))
        }
    }
}

struct DirectionsQuerySummary_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQuerySummary(model: OfferViewModel(start: FormStationListItem(code: "asd", name: "Szeged"), end: FormStationListItem(code: "asd", name: "Szeged"), passengerCount: 1, startDate: Date.now))
    }
}
