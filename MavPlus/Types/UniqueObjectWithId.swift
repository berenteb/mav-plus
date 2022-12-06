//
//  UniqueObjectWithId.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import Foundation

/// Data type for easy conformance with Identifiable, Equatable, and Hashable protocols
class UniqueObjectWithId: Identifiable, Equatable, Hashable {
    
    /// Globally Unique Identifier
    public let id: UUID
    
    /// Default initializer generating self.id
    public init() {
        self.id = UUID()
    }
    
    /// Overriding of == operator
    /// Required by Equatable protocol
    /// - Parameters:
    ///   - lhs: One of the operands to compare
    ///   - rhs: One of the operands to compare
    /// - Returns: Whether the id of the two operands are equal
    public static func ==(lhs: UniqueObjectWithId, rhs: UniqueObjectWithId) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    /// Required by Hashable protocol
    /// Only uses self.id for hashing
    /// - Parameter hasher: The hasher to hash into
    /// - Returns: Nothing
    public func hash(into hasher: inout Hasher) -> Void {
        hasher.combine(self.id)
    }
}
