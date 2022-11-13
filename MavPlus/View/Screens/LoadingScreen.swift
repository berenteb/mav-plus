import SwiftUI

struct LoadingScreen: View {
    @ObservedObject var model = LoadingViewModel()
    var body: some View {
        if model.isLoading{
            SpinnerView(size: 100)
        }else if model.isError{
            Text("Error", comment: "Error text")
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
