//
//  RssItem.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import Foundation

/// Data type representing an RSS feed item
class RssItem: UniqueObjectWithId {
    
    /// Title of the RSS item
    public let title: String
    
    /// The URL for the RSS item
    public var url: String
    
    /// Textual content of the RSS item
    public var content: String
    
    /// Default initializer
    /// - Parameters:
    ///   - title: Title of the RSS item
    ///   - url: The URL for the RSS item
    ///   - content: Textual content of the RSS item
    public init(title: String = String(), url: String = String(), content: String = String()) {
        self.title = title
        self.url = url
        self.content = content
        super.init()
    }
}
