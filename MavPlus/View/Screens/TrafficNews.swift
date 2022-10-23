//
//  TrafficNews.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct TrafficNews: View {
    
    @ObservedObject public var model: RssViewModel
    
    var body: some View {
        NavigationStack {
            List(self.model.rssItemList) { item in
                RssView(content: item, selectColor: Color.blue, unSelectColor: Color.teal)
            }
            .listStyle(.plain)
            .navigationTitle("Traffic News")
        }
    }
}

struct TrafficNews_Previews: PreviewProvider {
    static var previews: some View {
        TrafficNews(model: RssViewModel())
    }
}
