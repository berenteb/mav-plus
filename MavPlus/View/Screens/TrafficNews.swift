//
//  TrafficNews.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI
import WebKit

struct TrafficNews: View {
    @ObservedObject var model: AlertsViewModel = AlertsViewModel()
    
    var body: some View {
        NavigationStack {
            if model.isLoading{
                SpinnerView()
            }else if model.isError{
                ErrorView()
            }else{
                List(model.alerts) { alert in
                    if let url: URL = URL(string: alert.url) {
                        NavigationLink(destination: {
                            WebView(url: url).navigationBarTitleDisplayMode(.inline)
                        }, label: {
                            IconField(iconName: "exclamationmark.triangle", value: alert.title)
                        })
                    } else {
                        IconField(iconName: "exclamationmark.triangle", value: alert.title)
                    }
                }.navigationTitle(Text("Traffic News"))
            }
        }
    }
}

struct TrafficNews_Previews: PreviewProvider {
    static var previews: some View {
        TrafficNews()
    }
}
