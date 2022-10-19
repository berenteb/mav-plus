//
//  RssItem.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import Foundation

class RssItem: UniqueObjectWithId {
    
    public let title: String
    public var url: String
    public var content: String
    
    public init(title: String = String(), url: String = String(), content: String = String()) {
        self.title = title
        self.url = url
        self.content = content
        super.init()
    }
}
