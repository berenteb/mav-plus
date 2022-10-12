//
//  DirectionsQuerySummary.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQuerySummary: View {
    
    public let content: DirectionsQuery
    
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
                
                Text(self.content.startStation)
            }

            HStack {
                Text("To")
                .bold()
                
                Spacer()
                
                Text(self.content.endStation)
            }
            
            HStack {
                Text("When")
                .bold()
                
                Spacer()
                
                Text(self.content.time.formatted(date: .abbreviated, time: .shortened))
            }
            
            HStack {
                Text("Passengers")
                .bold()
                
                Spacer()
                
                Text(self.content.passengerNumber.description)
            }
        }
        .padding()
    }
}

struct DirectionsQuerySummary_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQuerySummary(content: DirectionsQuery(time: Date.now, isDepartureTime: true, startStation: "Vasalma", endStation: "Jónásapátfalva", passengerNumber: 1))
    }
}
