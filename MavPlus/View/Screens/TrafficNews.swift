//
//  TrafficNews.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI
import WebKit

fileprivate struct WebView: UIViewRepresentable {
    
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct TrafficNews: View {
    
    @ObservedObject public var model: RssViewModel
    
    var body: some View {
        NavigationStack {
            List(self.model.rssItemList) { item in
                if let actualUrl: URL = URL(string: item.url) {
                    NavigationLink(destination: {
                        WebView(url: actualUrl)
                    }, label: {
                        RssView(content: item, selectColor: Color.blue, unSelectColor: Color.blue)
                    })
                } else {
                    RssView(content: item, selectColor: Color.blue, unSelectColor: Color.blue)
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("Traffic News", comment: "RSS tabview title"))
        }
    }
}

struct TrafficNews_Previews: PreviewProvider {
    static var previews: some View {
        TrafficNews(model: RssViewModel())
    }
}
