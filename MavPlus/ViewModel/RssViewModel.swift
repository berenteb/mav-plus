//
//  RssViewModel.swift
//  MavPlus
//
//  Created by Márton Pfemeter on 2022-10-19.
//

import Foundation
import WebKit

internal protocol RssProtocol: RequestStatus, Updateable, ObservableObject, XMLParserDelegate {
    var rssItemList: [RssItem] {get}
}

fileprivate enum InterestingTag: String {
    case title
    case link
}

public class RssViewModel: NSObject, RssProtocol {
    @Published internal var rssItemList: [RssItem]
    @Published public var isError: Bool
    @Published public var isLoading: Bool
    
    private var lastTag: String?
    private var lastContent: String?
    private var parseList: [RssItem]
    
    public init(_ startWithUpdate: Bool = true) {
        self.rssItemList = [RssItem]()
        self.isError = false
        self.isLoading = true
        self.lastTag = nil
        self.lastContent = nil
        self.parseList = [RssItem]()
        super.init()
        
        if (startWithUpdate) {
            self.update()
        }
    }
    
    public func update() {
        self.isLoading = true
        self.parseList.removeAll()
        
        basicGetRequest(inputUrl: RssFeedRequestPath, completion: { inputData in
            self.startParsing(inputData: inputData)
            self.isLoading = false
        })
    }
    
    public func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) -> Void {
        if (self.lastTag != nil) {
            if let actualContent: String = self.lastContent {
                self.lastContent = actualContent + string
            } else {
                self.lastContent = string
            }
        }
    }
    
    private func startParsing(inputData: Data?) -> Void {
        if let realInputData: Data = inputData {
            let parser: XMLParser = XMLParser(data: realInputData)
            parser.delegate = self
            
            if (parser.parse()) {
                self.handleNewTag()
                
                DispatchQueue.main.async {
                    if (!self.parseList.isEmpty) {
                        self.rssItemList.removeAll()
                    }
                    
                    self.rssItemList.append(contentsOf: self.parseList)
                }
            }
        }
    }
    
    private func handleNewTag() -> Void {
        if let actualTag: String = self.lastTag {
            
            // if there is a new tag, we need to archive the data already collected
            if let actualContent: String = self.lastContent {
                switch actualTag {
                    case InterestingTag.title.rawValue:
                        self.parseList.append(RssItem(title: actualContent.trimmingCharacters(in: .whitespacesAndNewlines)))
                        break
                    case InterestingTag.link.rawValue:
                        if (!self.parseList.isEmpty) {
                            let localIndex: Int = (self.parseList.count - 1)
                            
                            if (self.parseList.last!.url.isEmpty) {
                                self.parseList[ localIndex ].url = actualContent.trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            
                            basicGetRequest(inputUrl: actualContent.trimmingCharacters(in: .whitespacesAndNewlines), completion: { inputData in
                                if let actualData: Data = inputData {
                                    // TODO: implement html parsing
                                }
                            })
                        }
                        
                        break
                    default:
                        break
                }
            }
        }
    }
    
    public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) -> Void {
        
        self.handleNewTag()
        
        if (elementName == InterestingTag.title.rawValue || elementName == InterestingTag.link.rawValue) {
            self.lastTag = elementName
        } else {
            self.lastTag = nil
        }
        
        self.lastContent = nil
    }
    
    
}

