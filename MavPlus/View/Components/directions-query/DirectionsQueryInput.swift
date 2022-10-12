//
//  DirectionsQueryInput.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQueryInput: View {
    
    @State private var startStation: String = String()
    @State private var endStation: String = String()
    @State private var time: Date = Date.now
    @State private var isDeparture: Bool = true
    @State private var passengerNumber: Int = 1
    
    public func getData() -> DirectionsQuery {
        let result: DirectionsQuery = DirectionsQuery(time: self.time, isDepartureTime: self.isDeparture, startStation: self.startStation, endStation: self.endStation, passengerNumber: self.passengerNumber)
        
        return result
    }
    
    var body: some View {
        GeometryReader { root in
            VStack {
                DirectionsQueryBase(content: [
                    TitledView(title: "From") {
                        TextField("Origin", text: self.$startStation)
                        .frame(maxWidth: (root.size.width / 2))
                        .padding(CGFloat(5))
                        .cornerRadius(CGFloat(5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 2)
                        )
                    },
                    TitledView(title: "To") {
                        TextField("Destination", text: self.$endStation)
                        .frame(maxWidth: (root.size.width / 2))
                        .padding(CGFloat(5))
                        .cornerRadius(CGFloat(5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 2)
                        )
                    },
                ])
                
                VStack(alignment: .leading, spacing: CGFloat(5)) {
                    HStack {
                        Text("When")
                        .bold()
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Toggle( (self.isDeparture ? "Leave at" : "Arrive by"), isOn: self.$isDeparture)
                            .frame(maxWidth: (root.size.width / 2))
                            
                            DatePicker(
                                "",
                                selection: self.$time,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                        }
                    }
                    
                    HStack {
                        Text("Passengers")
                        .bold()
                        
                        Spacer()
                        
                        Text(self.passengerNumber.description)
                        Stepper {
                            
                        } onIncrement: {
                            if (self.passengerNumber < 6) {
                                self.passengerNumber += 1
                            }
                        } onDecrement: {
                            if (self.passengerNumber > 1) {
                                self.passengerNumber -= 1
                            }
                        }
                        .frame(maxWidth: (root.size.width / 4))
                    }
                    
                    HStack {
                        Text("Options")
                        .bold()
                        
                        Spacer()
                        
                        
                    }
                }
            }
        }
    }
}

struct DirectionsQueryInput_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQueryInput()
    }
}
