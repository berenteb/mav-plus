//
//  DirectionsQuerySummary.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQuerySummary: View {
    
    @ObservedObject public var model: OfferViewModel
    
    private func getOptionsString(input: [String]) -> String {
        
        var realInput: [String] = input
        var result: String = (realInput.isEmpty ? String() : realInput.removeFirst())
        
        for optionsItem in realInput {
            result += " "
            result += optionsItem
        }
        
        return result
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: CGFloat(5)) {
            HStack {
                Text("From")
                .bold()
                
                Spacer()
                
                Text(self.model.startCode)
            }

            HStack {
                Text("To")
                .bold()
                
                Spacer()
                
                Text(self.model.endCode)
            }
            
            HStack {
                Text("When")
                .bold()
                
                Spacer()
                
                Text(self.model.startDate.formatted(date: .abbreviated, time: .shortened))
            }
            
            HStack {
                Text("Passengers")
                .bold()
                
                Spacer()
                
                Text(self.model.passengerCount.description)
            }
        }
        .padding()
    }
}

struct DirectionsQuerySummary_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQuerySummary(model: OfferViewModel(start: "Vasalma", end: "Jónásapátfalva", count: 1, date: Date.now))
    }
}
