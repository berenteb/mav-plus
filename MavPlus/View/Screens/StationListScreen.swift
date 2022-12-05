import SwiftUI

/// View listing every station
struct StationListScreen: View {
    
    /// Model handling debouncing of search TextInput
    @ObservedObject var searchField = TextFieldDebouncer()
    
    /// Data for the view.
    @ObservedObject var viewModel: StationListViewModel = StationListViewModel()
    
    /// SwiftUI view generation.
    var body: some View {
        NavigationView{
            List(filteredStations, id:\.code ){ item in
                NavigationLink(item.name){
                    StationDetailsScreen(code: item.code)
                }
            }.onAppear{
                viewModel.update()
            }.refreshable {
                viewModel.update()
            }.navigationTitle(Text("Stations"))
        }
        .navigationViewStyle(.stack)
        .searchable(
            text: $searchField.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
    
    /// Property returning the stations matching the search criteria (i.e. the text entered)
    var filteredStations: [StationListItem] {
        if searchField.debouncedText.isEmpty {
            let result: [StationListItem] = viewModel.stationList.sorted(by: >)
            return result
        } else {
            let result: [StationListItem] = viewModel.stationList.filter { $0.name.localizedCaseInsensitiveContains(searchField.debouncedText) }
            return result.sorted(by: >)
        }
    }
}

/// SwiftUI Preview
struct StationListView_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        StationListScreen()
    }
}
