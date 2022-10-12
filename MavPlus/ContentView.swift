import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView{
                HomeScreen().tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
