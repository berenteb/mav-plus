//
//  DirectionsOfferView.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-04.
//

import SwiftUI

struct DirectionsOfferView: View {
    
    public let content: OfferData
    public let selectColor: Color
    public let unSelectColor: Color
    
    public init(content: OfferData, selectColor: Color = Color.blue, unSelectColor: Color = Color.teal) {
        self.content = content
        self.selectColor = selectColor
        self.unSelectColor = unSelectColor
    }
    
    @State private var isSelected: Bool = false
    
    private func getTrainData() -> Text? {
        var result: Text? = nil
        
        if let actualType: String = self.content.type {
            result = Text(actualType) + Text(" ")
        }
        
        if let actualName: String = self.content.name {
            let localText: Text = Text(actualName) + Text(" ")
            
            guard result != nil else {
                result = localText
                return result
            }
            
            result = result! + localText
        }
        
        return result
    }
    
    var body: some View {
        SelectableTile(selectColor: self.selectColor, unSelectColor: self.unSelectColor, isSelected: self.$isSelected) {
            VStack(alignment: .leading, spacing: CGFloat(7)) {
                HStack {
                    /*
                    Text(self.content.startTime.formatted(date: .omitted, time: .shortened)) + Text("-") + Text(self.content.endTime.formatted(date: .omitted, time: .shortened))
                     */
                    Text(self.content.travelTime)
                    
                    Spacer()
                    
                    Text(self.content.price.description) + Text(" HUF")
                }
                
                Group {
                    if let actualTrainData: Text = self.getTrainData() {
                        actualTrainData
                    }
                }
            }
        }
    }
}

struct DirectionsOfferView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsOfferView(
            content: OfferData(startStationName: "Vasalma", endStationName: "Budapest Keleti", price: "2000 HUF", travelTime: "16min", transferCount: 1),
            selectColor: Color.blue, unSelectColor: Color.teal
        )
    }
}
