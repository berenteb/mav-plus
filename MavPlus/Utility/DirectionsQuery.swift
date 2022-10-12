//
//  DirectionsQuery.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import Foundation

class DirectionsQuery: UniqueObjectWithId {
    
    public let time: Date
    public let isDepartureTime: Bool
    public let startStation: String
    public let endStation: String
    public let passengerNumber: Int
    
    public init(time: Date, isDepartureTime: Bool, startStation: String, endStation: String, passengerNumber: Int) {
        self.time = time
        self.isDepartureTime = isDepartureTime
        self.startStation = startStation
        self.endStation = endStation
        self.passengerNumber = passengerNumber
        super.init()
    }
}
