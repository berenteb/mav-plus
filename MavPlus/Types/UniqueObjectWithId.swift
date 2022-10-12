//
//  UniqueObjectWithId.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import Foundation

class UniqueObjectWithId: Identifiable, Equatable, Hashable {
    
    public let id: UUID
    
    public init() {
        self.id = UUID()
    }
    
    public static func ==(lhs: UniqueObjectWithId, rhs: UniqueObjectWithId) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    public func hash(into hasher: inout Hasher) -> Void {
        hasher.combine(self.id)
    }
}
