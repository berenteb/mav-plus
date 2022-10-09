import Foundation

protocol RequestStatus {
    var isError: Bool {get}
    var isLoading: Bool {get}
}

protocol Updateable {
    func update() -> Void
}
