//
//  DirectionsQueryInput.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQueryInput: View {
    
    @State var startStation: String = ""
    @State var endStation: String = ""
    @State var time: Date = Date()
    @State var isArrival: Bool = false
    @State var passengerNumber: Int = 1
    
    var body: some View {
            Form{
                Section("Route"){
                    TextField("From", text: $startStation)
                    TextField("To", text: $endStation)
                }
                Section("Date"){
                    DatePicker("Date", selection: $time)
                    Toggle("Arrive by", isOn: $isArrival)
                }
            }
    }
}

struct DirectionsQueryInput_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQueryInput()
    }
}
