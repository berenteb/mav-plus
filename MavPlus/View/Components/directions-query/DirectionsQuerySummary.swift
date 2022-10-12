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
    
    private func generateContent() -> [TitledView<Text>] {
        return [
            TitledView(title: "From")       { Text(self.content.startStation) },
            TitledView(title: "To")         { Text(self.content.endStation) },
            TitledView(title: "When")       { Text(self.content.time.formatted(date: .abbreviated, time: .shortened)) },
            TitledView(title: "Passengers") { Text(self.content.passengerNumber.description) }
        ]
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: CGFloat(5)) {
            ForEach(self.generateContent()) { viewItem in
                HStack {
                    Text(viewItem.title)
                    .bold()
                    
                    Spacer()
                    
                    viewItem.content
                }
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
