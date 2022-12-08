import Foundation

/// Protocol for a request's status
protocol RequestStatus {
    
    /// Whether the request resulted in an error
    var isError: Bool {get}
    
    /// Whether the request is still loading
    var isLoading: Bool {get}
}

/// Protocol for updatable classes
protocol Updateable {
    
    /// Function updating the classes state
    /// - Returns: Nothing
    func update() -> Void
}
