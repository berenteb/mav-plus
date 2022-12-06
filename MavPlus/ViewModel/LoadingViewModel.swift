import Foundation
import Combine

///Loading view model to handle initial API calls, wait for them and indicate error or loading
class LoadingViewModel: ObservableObject, RequestStatus{
    @Published var isLoading: Bool
    @Published var isError: Bool
    private var cancellables = Set<AnyCancellable>()
    init(){
        isLoading = ApiRepository.shared.isLoading
        isError = ApiRepository.shared.isError
        ApiRepository.shared.notifier.sink{
            self.isLoading = ApiRepository.shared.isLoading
            self.isError = ApiRepository.shared.isError
        }.store(in: &cancellables)
    }
    func update(){
        ApiRepository.shared.update()
    }
}
