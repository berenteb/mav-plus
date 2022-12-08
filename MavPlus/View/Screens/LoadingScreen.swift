import SwiftUI

/// View presenting a loading screen with a spinning loading icon
struct LoadingScreen: View {
    
    /// Data for the view.
    @ObservedObject var model = LoadingViewModel()
    
    /// SwiftUI view generation.
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

/// SwiftUI Preview
struct LoadingScreen_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        LoadingScreen()
    }
}
