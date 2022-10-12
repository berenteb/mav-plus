//
//  TrafficNews.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct TrafficNews: View {
    
    @State private var content: [RssItem] = [RssItem]()
    
    // Gets RSS data from backend
    private func fetchRssData() -> Void {
        self.content = [
            RssItem(title: "MyTitle", preview: "Something happened...", content: "Lorem ipsum dolor."),
            RssItem(title: "MyBestTitle", preview: "Something other happened...", content: "Lorem ipsum!"),
            RssItem(title: "YourTitle", preview: "Something different happened...", content: "Lorem dolor."),
        ]
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.content) { item in
                    RssView(content: item, selectColor: Color.blue, unSelectColor: Color.teal)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Traffic News")
            .onAppear() {
                self.fetchRssData()
            }
        }
    }
}

struct TrafficNews_Previews: PreviewProvider {
    static var previews: some View {
        TrafficNews()
    }
}
