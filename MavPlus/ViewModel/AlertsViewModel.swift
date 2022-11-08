//
//  RssViewModel.swift
//  MavPlus
//
//  Created by Márton Pfemeter on 2022-10-19.
//

import Foundation
import Combine

struct Alert: Identifiable{
    var id: UUID
    var title: String
    var url: String
    var content: String
}

public class AlertsViewModel: ObservableObject {
    @Published var alerts: [Alert]
    @Published var isError: Bool
    @Published var isLoading: Bool
    
    private var disposables = Set<AnyCancellable>()
    
    init(){
        isError = RssRepository.shared.isError
        isLoading = RssRepository.shared.isLoading
        alerts = RssRepository.shared.rssItemList.map{item in
            return Alert(id: item.id, title: item.title, url: item.url, content: item.content)
        }
        subscribe()
    }
    
    func subscribe(){
        RssRepository.shared.publisher.sink{fields in
            self.isError = fields.isError
            self.isLoading = fields.isLoading
            self.alerts = fields.rssItemList.map{item in
                return Alert(id: item.id, title: item.title, url: item.url, content: item.content)
            }
        }.store(in: &disposables)
    }
}

