//
//  RssItem.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import Foundation

class RssItem: UniqueObjectWithId {
    
    public let title: String
    public let preview: String
    public let content: String
    
    public init(title: String = String(), preview: String = String(), content: String = String()) {
        self.title = title
        self.preview = preview
        self.content = content
        super.init()
    }
}
