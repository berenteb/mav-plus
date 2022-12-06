import Foundation
import Combine

/// Class handling debouncing (delaying) of a TextField's input
class TextFieldDebouncer : ObservableObject {
    
    /// Delayed text
    @Published var debouncedText = ""
    
    /// Instantly up to date text
    @Published var searchText = ""
    
    // TODO
    private var subscriptions = Set<AnyCancellable>()
    
    
    /// Default initializer setting a 0.5 second delay on self.searchText before adding it to self.debouncedText
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] t in
                self?.debouncedText = t
            } )
            .store(in: &subscriptions)
    }
}
