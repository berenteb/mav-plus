import Foundation
import Combine

class LoadingViewModel: ObservableObject{
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
