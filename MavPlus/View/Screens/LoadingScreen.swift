import SwiftUI

struct LoadingScreen: View {
    @ObservedObject var model = LoadingViewModel()
    var body: some View {
        if model.isLoading{
            SpinnerView(size: 100)
        }else if model.isError{
            if model.isLoading{
                LoadingScreen()
            }else if model.isError{
                ErrorView(onRetry: model.update)
            }
        }else{
            RootNavigation()
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
