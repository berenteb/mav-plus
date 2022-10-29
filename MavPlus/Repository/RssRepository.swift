import Foundation
import WebKit
import Combine

protocol RssProtocol: RequestStatus, Updateable, XMLParserDelegate {
    var rssItemList: [RssItem] {get}
    var publisher: PassthroughSubject<RssFields, Never> { get }

}

enum InterestingTag: String {
    case title
    case link
}

struct RssFields {
    var rssItemList: [RssItem]
    var isError: Bool
    var isLoading: Bool
}

public class RssRepository: NSObject, RssProtocol {
    static var shared = RssRepository() as (any RssProtocol)
    var rssItemList: [RssItem]
    var isError: Bool
    var isLoading: Bool
    
    private var lastTag: String?
    private var lastContent: String?
    private var parseList: [RssItem]
    
    var publisher = PassthroughSubject<RssFields, Never>()
    
    public override init() {
        self.rssItemList = []
        self.isError = false
        self.isLoading = true
        self.lastTag = nil
        self.lastContent = nil
        self.parseList = []
        super.init()
        update()
    }
    
    public func update() {
        self.isLoading = true
        self.parseList.removeAll()
        
        guard let url: URL = URL(string: RssFeedRequestPath) else {
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                return
            }
            
            if let data = data {
                self.startParsing(inputData: data)
            }
            
            self.isLoading = false
        }
        
        task.resume()
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
                    self.publisher.send(RssFields(rssItemList: self.rssItemList, isError: self.isError, isLoading: self.isLoading))
                }
            }
        }
    }
    
    private func handleNewTag() -> Void {
        if let actualTag = self.lastTag, let actualContent = self.lastContent {
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
                }
                
                break
            default:
                break
            }
        }
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

