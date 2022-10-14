//
//  DirectionsQueryInput.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQueryInput: View {
    
    @Binding public var startStation: String
    @Binding public var endStation: String
    @Binding public var time: Date
    @Binding public var isDeparture: Bool
    @Binding public var passengerNumber: Int
    
    var body: some View {
        GeometryReader { root in
            VStack(alignment: .leading, spacing: CGFloat(5)) {
                
                HStack {
                    Text("From")
                        .bold()
                    
                    Spacer()
                    
                    TextField("Origin", text: self.$startStation)
                        .frame(maxWidth: (root.size.width / 2))
                        .padding(CGFloat(5))
                        .cornerRadius(CGFloat(5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 2)
                        )
                }
                
                HStack {
                    Text("To")
                        .bold()
                    
                    Spacer()
                    
                    TextField("Destination", text: self.$endStation)
                        .frame(maxWidth: (root.size.width / 2))
                        .padding(CGFloat(5))
                        .cornerRadius(CGFloat(5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 2)
                        )
                }
                
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
            }
        }
    }
}

struct DirectionsQueryInput_Previews: PreviewProvider {
    
    @State private static var startStation: String = String()
    @State private static var endStation: String = String()
    @State private static var time: Date = Date.now
    @State private static var isDeparture: Bool = true
    @State private static var passengerNumber: Int = 1
    
    static var previews: some View {
        DirectionsQueryInput(
            startStation: self.$startStation,
            endStation: self.$endStation,
            time: self.$time,
            isDeparture: self.$isDeparture,
            passengerNumber: self.$passengerNumber
        )
    }
}
